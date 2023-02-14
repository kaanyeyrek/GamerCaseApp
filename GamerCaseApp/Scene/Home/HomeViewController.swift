//
//  ViewController.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/9/23.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func setUI()
    func setNavBarTitleFeatures()
    func setSubviews()
    func setLayout()
    func setTableView()
    func reloadTable()
    func setSearchController()
    func changeLoading(isLoad: Bool)
    func handleOutput(output: HomeViewModelOutput)
    func navigate(route: HomeViewModelRoute)
}

final class HomeViewController: UIViewController {
//MARK: - UI Injection Global
    private lazy var viewModel: HomeViewModelInterface = HomeViewModel(view: self)
    private var homePresentation = [HomePresentation]()
    private var filteredPresentation = [filterPresentation]()
//MARK: - UI Elements Global
    private var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private let table = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
//MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}
//MARK: - HomeViewInterface Methods
extension HomeViewController: HomeViewInterface {
    func setUI() {
        view.backgroundColor = .systemBackground
    }
    func setNavBarTitleFeatures() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func setSubviews() {
        [indicator, table].forEach { elements in
            view.addSubview(elements)
        }
    }
    func setLayout() {
        table.anchor(top: searchController.searchBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: view.frame.height))
        table.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60).isActive = true
        indicator.startAnimating()
        indicator.centerInSuperView(size: .init(width: 250, height: 250))
    }
    func setTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: ReuseIdentifier.homeCell)
        table.keyboardDismissMode = .interactive
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
    }
    func reloadTable() {
        table.reloadData()
    }
    // search controller configure
    func setSearchController() {
        searchController.searchBar.placeholder = "Search for the games"
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    // loading data status
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    // handle output viewModel
    func handleOutput(output: HomeViewModelOutput) {
        switch output {
        case .uploadPresentation(let games):
            self.homePresentation = games
            self.reloadTable()
        case .failedUpdateData(let message, let title):
            print(message, title)
        case .empty(let message):
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, at: self.view)
            }
        case .filteredPresentation(let filtered):
            self.filteredPresentation = filtered
            self.reloadTable()
        case .removeEmpty:
            self.removeEmptyStateView()
        }
    }
    // navigate detail vc
    func navigate(route: HomeViewModelRoute) {
        switch route {
        case .detail(let viewModel):
        let vc = DetailBuilder.make(viewModel: viewModel)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
//MARK: - UITableViewDataSource Methods
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredPresentation.count
        } else {
            return homePresentation.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.homeCell, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        // search query activeted for network
        if searchController.isActive == true {
            let model = filteredPresentation[indexPath.row]
            cell.setGameLabelFilter(model: model)
            cell.setGameImageFilter(model: model)
            cell.setMetacriticLabel()
            cell.setMetacriticCountFilter(model: model)
            return cell
        } else {
        // default request for network
            let model = homePresentation[indexPath.row]
            cell.setImage(model: model)
            cell.setGameLabel(model: model)
            cell.setMetacriticLabel()
            cell.setMetacriticCount(model: model)
            cell.setGenres(model: model)
            cell.setID(model: model)
        }
        return cell
    }
}
//MARK: - UITableViewDelegate Methods
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(at: indexPath.row)
        table.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .init(160)
    }
    // Swipe from bottom to top for pagination support app
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = table.frame.height
        let offset = table.contentOffset.y
        let contentHeight = table.contentSize.height
        if searchController.isActive {
            viewModel.pagination(height: height, offset: offset, contentHeight: contentHeight)
            table.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
}
//MARK: - UISearchBarDelegate Methods
extension HomeViewController: UISearchBarDelegate {
    // User search textdidChange
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.showEmptyStateView(with: "No game has been searched.", at: self.view)
        viewModel.newSearch()
            if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    searchBar.resignFirstResponder()
                    self.indicator.stopAnimating()
                }
        }
        indicator.startAnimating()
        timer?.invalidate()
        guard let query = searchBar.text, !query.isEmpty else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            self.viewModel.searchData(querys: query)
            self.removeEmptyStateView()
            }
    }
    // Search cancel button methods
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchGames()
        self.reloadTable()
    }
}

