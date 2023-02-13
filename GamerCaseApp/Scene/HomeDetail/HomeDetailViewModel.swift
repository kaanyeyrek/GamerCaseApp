//
//  HomeDetailViewModel.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/13/23.
//

import Foundation

protocol HomeDetailViewModelImterface {
    func viewDidLoad()
    func setPresentation()
}

final class HomeDetailViewModel {
    // inject
    weak var view: HomeDetailViewInterface?
//MARK: - UI Components
    private var games: GameResult
    
    init(games: GameResult) {
        self.games = games
    }
}
//MARK: - HomeDetailViewModel Interface
extension HomeDetailViewModel: HomeDetailViewModelImterface {
    //MARK: - LifeCycle
    func viewDidLoad() {
        view?.setUI()
    }
    // Helper
    private func notify(output: HomeDetailOutput) {
        view?.handleOutput(output: output)
    }
    func setPresentation() {
        let detailPresentation = HomePresentation(model: games)
        notify(output: .loadPresentation(detailPresentation))
    }
}
