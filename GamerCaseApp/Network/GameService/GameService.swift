//
//  GameService.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/9/23.
//

import Foundation

protocol GameServiceInterface {
    func fetchGames(endpoint: GameEndPoint, completion: @escaping (Result<GameModel, NetworkError>) -> Void)
    func searchGames(endpoint: GameEndPoint, completion: @escaping (Result<GameModel, NetworkError>) -> Void)
}

final class GameService: GameServiceInterface {
    private var manager: CoreServiceProtocol!
    // Inject
    init(manager: CoreServiceProtocol!) {
        self.manager = manager
    }
    // Fetch Games
    func fetchGames(endpoint: GameEndPoint, completion: @escaping (Result<GameModel, NetworkError>) -> Void) {
        manager.fetch(endPoint: endpoint) { (result: Result<GameModel, NetworkError>) in
            completion(result)
        }
    }
    // Search
    func searchGames(endpoint: GameEndPoint, completion: @escaping (Result<GameModel, NetworkError>) -> Void) {
        manager.fetch(endPoint: endpoint) { (result: Result<GameModel, NetworkError>) in
            completion(result)
        }
    }
}
