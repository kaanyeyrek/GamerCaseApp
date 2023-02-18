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
}

@available(iOS 13.0, *)
final class FavoritesViewController: UIViewController {
//MARK: - UI Injections
    private lazy var viewModel: FavoritesViewModelInterface = FavoritesViewModel(view: self)
//MARK: - UI Elements
    private var table = UITableView()
    private var favoritesPresentation: [FavoritesPresentation] = []
//MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
        let itemCount = CoreDataManager().getItemCount()
        title = "Favourites (\(itemCount))"
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
        case .uploadPresentation(let presentation):
            self.favoritesPresentation = presentation
            self.reloadTable()
        }
    }
}
//MARK: - UITableViewDatasource Methods
@available(iOS 13.0, *)
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritesPresentation.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.favoritesCell, for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell()
        }
        cell.backgroundColor = UIColor(hex: Color.white)
        let presentation = favoritesPresentation[indexPath.row]
        cell.setFavoritesImage(presentation: presentation)
        cell.setFavoritesGameLabel(presentation: presentation)
        cell.setFavoritesMetacriticLabel()
        cell.setMetacriticCount(presentation: presentation)
        cell.setGenres(presentation: presentation)
        return cell
    }
}
//MARK: - UITableViewDelegate Methods
@available(iOS 13.0, *)
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .init(170)
    }
}
