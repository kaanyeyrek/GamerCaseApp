//
//  HomeViewModel.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/9/23.
//

import Foundation

protocol HomeViewModelInterface {
    func viewWillAppear()
    func viewDidLoad()
    func fetchGames()
    func changeLoadingStatus()
    var numberOfRowsInSection: Int { get }
}

final class HomeViewModel {
//MARK: - Global Inject
    private weak var view: HomeViewInterface?
    private var service: GameServiceInterface
    private var model: [GameResult] = []
//MARK: - Global ViewModel Elements
    private var pageSize: Int = 10
    private var page: Int = 1
    private var isLoad: Bool = false
    private var moreGames: Bool = true
    
    // Inject interface and game service
    init(view: HomeViewInterface, service: GameServiceInterface = GameService(manager: CoreService())) {
        self.view = view
        self.service = service
    }
}
//MARK: - HomeViewModelInterface Methods
extension HomeViewModel: HomeViewModelInterface {
    // Helper
    private func notify(output: HomeViewModelOutput) {
        view?.handleOutput(output: output)
    }
    func changeLoadingStatus() {
        isLoad = !isLoad
        view?.changeLoading(isLoad: isLoad)
    }
    // LifeCycle
    func viewWillAppear() {
        view?.setNavBarTitleFeatures()
    }
    func viewDidLoad() {
        view?.setUI()
        view?.setTableView()
        view?.setNavBarTitleFeatures()
        view?.setSearchController()
        view?.setSubviews()
        view?.setLayout()
        fetchGames()
    }
    // Fetching network
    func fetchGames() {
        changeLoadingStatus()
        service.fetchGames(endpoint: .fetchGames(size: pageSize, page: page)) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.changeLoadingStatus()
                switch result {
                case .success(let games):
                    self.updateData(with: games)
                    print(games)
                case .failure(let error):
                    self.notify(output: .failedUpdateData(message: error.rawValue, title: "Failed fetch data"))
                }
            }
        }
    }
    private func updateData(with games: GameModel) {
        if games.results.count <= 0 {
            moreGames = false
        }
        self.model.append(contentsOf: games.results)
        self.model = self.model.removeDuplicates()
        let games = self.model.map { HomePresentation(model: $0) }
        self.notify(output: .uploadPresentation(presentation: games))
        if self.model.isEmpty {
            notify(output: .empty(message: "Sorry, no game info right now"))
        } else {
            notify(output: .removeEmpty)
        }
    }
    var numberOfRowsInSection: Int {
        model.count
    }
    
}
