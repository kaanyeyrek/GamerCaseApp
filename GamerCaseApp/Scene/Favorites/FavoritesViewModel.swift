//
//  FavoritesViewModel.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/18/23.
//

import Foundation

protocol FavoritesViewModelInterface {
    func viewDidLoad()
    func viewWillAppear()
    func deleteFavorite(indexPath: Int, completion: () -> Void)
    func cellForRow(indexPath: IndexPath) -> Games?
    var numberOfRowSection: Int { get }
    func didSelectRowAt(index: Int)
}

@available(iOS 13.0, *)
final class FavoritesViewModel {
    // inject
    private weak var view: FavoritesViewInterface?
    private let service: CoreDataManagerInterface
    private var games = [Games]()
    
    init(view: FavoritesViewInterface, service: CoreDataManagerInterface = CoreDataManager()) {
        self.view = view
        self.service = service
    }
}
//MARK: - FavoritesViewModelInterface Methods
@available(iOS 13.0, *)
extension FavoritesViewModel: FavoritesViewModelInterface {
    // LifeCycle
    func viewWillAppear() {
        games = service.fetch()
        if games.isEmpty {
            notify(output: .showEmptyView(message: "There is no favourites found"))
        } else {
            notify(output: .removeEmptyView)
        }
    }
    func viewDidLoad() {
        view?.setUI()
        view?.setTableView()
        view?.setSubviews()
        view?.setLayout()
    }
    // Helper
    private func notify(output: FavoriteOutput) {
        view?.handleOutput(output: output)
    }
    var numberOfRowSection: Int {
        games.count
    }
    func cellForRow(indexPath: IndexPath) -> Games? {
        games.count > indexPath.row ? games[indexPath.row] : nil
    }
    func deleteFavorite(indexPath: Int, completion: () -> Void) {
        CoreDataManager().deleteFavorites(model: self.games[indexPath])
        games.remove(at: indexPath)
        if games.isEmpty {
            notify(output: .showEmptyView(message: "There is no favourites found"))
        } else {
            notify(output: .removeEmptyView)
        }
        completion()
    }
    func didSelectRowAt(index: Int) {
       // go favorites details vc
    }
}
