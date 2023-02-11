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
}

final class HomeViewController: UIViewController {
//MARK: - UI Injection Global
    private lazy var viewModel: HomeViewModelInterface = HomeViewModel(view: self)
    private var homePresentation = [HomePresentation]()
//MARK: - UI Elements Global
    private var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private let table = UITableView()
    private let searchController = UISearchController()
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
    func setSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for the games"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    // loading data status
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
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
        case .removeEmpty:
            self.removeEmptyStateView()
        }
    }
}
//MARK: - UITableViewDataSource Methods
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.homeCell, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        let model = homePresentation[indexPath.row]
        cell.setImage(model: model)
        cell.setGameLabel(model: model)
        cell.setMetacriticLabel()
        cell.setMetacriticCount(model: model)
        cell.setGenres(model: model)
        cell.setID(model: model)
        return cell
    }
}
//MARK: - UITableViewDelegate Methods
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .init(140)
    }
}
//MARK: - UISearchBarDelegate Methods
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}
