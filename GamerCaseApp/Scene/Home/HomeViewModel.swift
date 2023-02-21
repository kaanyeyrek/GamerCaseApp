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
    func searchData(querys: String)
    func pagination(height: CGFloat, offset: CGFloat, contentHeight: CGFloat)
    func newSearch()
    func didSelectRowAt(at index: Int)
    func saveApiKey()
    func loadApiKey() -> String?
}

final class HomeViewModel {
//MARK: - Global Inject
    private weak var view: HomeViewInterface?
    private var service: GameServiceInterface
    var model: [GameResult] = []
    private var filteredModel: [GameResult] = []
//MARK: - Global ViewModel Elements
    private var pageSize: Int = 10
    private var currentPage: Int = 1
    private var isLoad: Bool = false
    private var moreGames: Bool = true
    private var userQuery: String = ""
    private let apiManager = APIManager()

    
    // Inject interface and game service
    init(view: HomeViewInterface, service: GameServiceInterface = GameService(manager: CoreService())) {
        self.view = view
        self.service = service
    }
    // xcconfig build info and keychain security saved
    func saveApiKey() {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
           guard let key = apiKey, !key.isEmpty else {
               print("API key does not exist")
               return
           }
           _ = apiManager.saveApiKey(apiKey: apiKey!)
        }
    func loadApiKey() -> String? {
            return apiManager.loadApiKey()
        }
}
//MARK: - HomeViewModelInterface Methods
@available(iOS 13.0, *)
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
        view?.setKey()
        view?.setTableView()
        view?.setNavBarTitleFeatures()
        view?.setSearchController()
        view?.setSubviews()
        view?.setLayout()
        fetchGames()
    }
    // Fetching default network
    func fetchGames() {
        changeLoadingStatus()
        service.fetchGames(endpoint: .fetchGames(size: pageSize, page: currentPage)) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.changeLoadingStatus()
                switch result {
                case .success(let games):
                    self.updateData(with: games)
                case .failure(let error):
                    self.notify(output: .failedUpdateData(message: error.rawValue, title: "Failed fetch data"))
                }
            }
        }
    }
    // update home game data
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
    // Search filter query games
    func searchData(querys: String) {
        changeLoadingStatus()
        userQuery = querys
        service.searchGames(endpoint: .searchGames(size: pageSize, search: userQuery, page: currentPage)) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.changeLoadingStatus()
                switch result {
                case .success(let games):
                    self.updateSearchResults(models: games)
                case .failure(let error):
                    self.notify(output: .failedUpdateData(message: "Failed search", title: error.rawValue))
                }
            }
        }
    }
    //Update query search results
    func updateSearchResults(models: GameModel) {
        if models.results.count <= 0 {
            self.moreGames = false
        } else {
            self.moreGames = true
        }
        self.filteredModel.insert(contentsOf: models.results, at: 0)
        self.filteredModel = self.filteredModel.removeDuplicates()
        let games = self.filteredModel.map { filterPresentation(model: $0) }
        self.notify(output: .filteredPresentation(presentation: games))
        if self.model.isEmpty {
            notify(output: .empty(message: "No game has been searched."))
        } else {
            notify(output: .removeEmpty)
        }
    }
    // Clear new search
    func newSearch() {
        userQuery = ""
        filteredModel.removeAll()
        currentPage = 1
    }
    // Swipe from bottom to top for pagination
    func pagination(height: CGFloat, offset: CGFloat, contentHeight: CGFloat) {
        if !filteredModel.isEmpty, !model.isEmpty {
            if height + offset - 50 >= contentHeight {
                if moreGames {
                    currentPage += 1
                    searchData(querys: userQuery)
                }
            }
        }
    }
    // Show detail screen
    func didSelectRowAt(at index: Int) {
        let viewModel = HomeDetailViewModel(selectedID: model[index].id, models: model[index])
        view?.navigate(route: .detail(viewModel: viewModel))
    }
}
