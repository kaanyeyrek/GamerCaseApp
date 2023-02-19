//
//  FavoritesViewController.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/9/23.
//

import UIKit

protocol FavoritesViewInterface: AnyObject {
    func setUI()
    func setLayout()
    func setTableView()
    func reloadTable()
    func setSubviews()
    func handleOutput(output: FavoriteOutput)
    func setTitleFeatures()
}

@available(iOS 13.0, *)
final class FavoritesViewController: UIViewController {
//MARK: - UI Injections
    private lazy var viewModel: FavoritesViewModelInterface = FavoritesViewModel(view: self)
//MARK: - UI Elements
    private var table = UITableView()
//MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
        setTitleFeatures()
        table.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}
//MARK: - FavoritesViewInterface Methods
@available(iOS 13.0, *)
extension FavoritesViewController: FavoritesViewInterface {
    func setUI() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(hex: Color.white)
    }
    func setTitleFeatures() {
        let itemCount = CoreDataManager().getItemCount()
        title = "Favourites (\(itemCount))"
    }
    func setSubviews() {
        [table].forEach { elements in
            view.addSubview(elements)
        }
    }
    func setLayout() {
        table.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, size: .init(width: view.frame.width, height: view.frame.height-100))
    }
    func setTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(FavoritesTableViewCell.self, forCellReuseIdentifier: ReuseIdentifier.favoritesCell)
        table.keyboardDismissMode = .interactive
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.backgroundColor = UIColor(hex: Color.favoritesColor)
    }
    func reloadTable() {
        table.reloadData()
    }
    // handle output
    func handleOutput(output: FavoriteOutput) {
        switch output {
        case .showEmptyView(let message):
            self.showEmptyStateView(with: message, at: self.view)
        case .removeEmptyView:
            self.removeEmptyStateView()
        }
    }
}
//MARK: - UITableViewDatasource Methods
@available(iOS 13.0, *)
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowSection
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.favoritesCell, for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell()
        }
        cell.backgroundColor = UIColor(hex: Color.white)
        guard let model = viewModel.cellForRow(indexPath: indexPath) else { return cell}
        cell.setFavoritesImage(presentation: model)
        cell.setFavoritesGameLabel(presentation: model)
        cell.setFavoritesMetacriticLabel()
        cell.setMetacriticCount(presentation: model)
        cell.setGenres(presentation: model)
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.showAlertWithConfirmation(title: "Approval", message: "Do you want to continue?") {
                let selectedIndex = indexPath.row
                self.viewModel.deleteFavorite(indexPath: selectedIndex) {
                    DispatchQueue.main.async {
                        tableView.beginUpdates()
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        self.setTitleFeatures()
                        self.reloadTable()
                        tableView.endUpdates()
                    }
                }
            }
        }
    }
}
//MARK: - UITableViewDelegate Methods
@available(iOS 13.0, *)
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRowAt(index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .init(170)
    }
}
