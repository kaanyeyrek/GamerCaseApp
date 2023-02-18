//
//  HomeDetailViewModel.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/13/23.
//

import Foundation

protocol HomeDetailViewModelInterface {
    var view: HomeDetailViewInterface? { get set }
    func viewDidLoad()
    func setData()
    func changeLoadStatus()
    func viewWillAppear()
    func favoriteTapped(isSelected: Bool)
    var games: GameDetailModel? { get set }
}

final class HomeDetailViewModel {
    // inject ui
    weak var view: HomeDetailViewInterface?
    // selected game id
    private var selectedID: Int
    private var isload = false
//MARK: - UI Components
    // inject detail service
    private var service: GameServiceInterface
    // model
    var games: GameDetailModel?
    // init
    init(selectedID: Int, service: GameServiceInterface = GameService(manager: CoreService())) {
        self.service = service
        self.selectedID = selectedID
    }
}
//MARK: - HomeDetailViewModel Interface
extension HomeDetailViewModel: HomeDetailViewModelInterface {
    //MARK: - LifeCycle
    func viewWillAppear() {
        view?.setBarButton()
    }
    func viewDidLoad() {
        view?.setUI()
        view?.setSubviews()
        view?.setLayout()
        view?.setGradientLayer()
        view?.setTargets()
    }
    // Helper
    private func notify(output: HomeDetailOutput) {
        view?.handleOutput(output: output)
    }
    // select detail network // 2st network request
    func setData() {
        changeLoadStatus()
        service.getDetails(endpoint: .getDetail(id: selectedID)) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.changeLoadStatus()
                switch result {
                case .success(let games):
                    self.games = games
                    self.view?.configureUI()
                case .failure(let error):
                    self.notify(output: .failedUpdateData(message: error.rawValue, title: "Failed detail fetch"))
                }
            }
        }
    }
    // activity indicator status
    func changeLoadStatus() {
        isload = !isload
        view?.changeLoading(isLoad: isload)
    }
    func favoriteTapped(isSelected: Bool) {
        if isSelected {
            
        } else {
            
        }
    }
    // Check Helper
//    private func checkSaveInfo() -> Bool {
//       
//    }
}
