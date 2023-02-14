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
    func updateData(model: GameDetailModel)
    func changeLoadStatus()
}

final class HomeDetailViewModel {
    // inject ui
    weak var view: HomeDetailViewInterface?
    // selected game id
    private var selectedID: Int
    private var moreDetail: Bool = true
    private var isload = false
//MARK: - UI Components
    // inject detail service
    private var service: GameServiceInterface
    private var detailModel: [GameDetailModel] = []
    // init
    init(selectedID: Int, service: GameServiceInterface = GameService(manager: CoreService())) {
        self.service = service
        self.selectedID = selectedID
    }
}
//MARK: - HomeDetailViewModel Interface
extension HomeDetailViewModel: HomeDetailViewModelInterface {
    //MARK: - LifeCycle
    func viewDidLoad() {
        view?.setUI()
        view?.setTableView()
        view?.setSubviews()
        view?.setLayout()
        setData()
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
                    self.updateData(model: games)
                case .failure(let error):
                    self.notify(output: .failedUpdateData(message: error.rawValue, title: "Failed detail fetch"))
                }
            }
        }
    }
    // update array
    func updateData(model: GameDetailModel) {
        if model.description.count <= 1 {
            moreDetail = false
        }
            self.detailModel.append(model)
            self.detailModel = self.detailModel.removeDuplicates()
            let detailGames = self.detailModel.map { HomeDetailPresentation(model: $0)}
            self.notify(output: .loadPresentation(detailGames))
        if self.detailModel.isEmpty {
            self.notify(output: .empty(message: "No game has been detail"))
        } else {
            self.notify(output: .removeEmpty)
        }
    }
    // activity indicator status
    func changeLoadStatus() {
        isload = !isload
        view?.changeLoading(isLoad: isload)
    }
}
