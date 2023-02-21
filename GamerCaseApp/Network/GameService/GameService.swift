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
    func getDetails(endpoint: GameEndPoint, completion: @escaping (Result<GameDetailModel, NetworkError>) -> Void)
}
// Game Service Request
final class GameService: GameServiceInterface {
    private var manager: CoreServiceProtocol!
    // Dependency inject
    init(manager: CoreServiceProtocol!) {
        self.manager = manager
    }
    // Default Games
    func fetchGames(endpoint: GameEndPoint, completion: @escaping (Result<GameModel, NetworkError>) -> Void) {
        manager.fetch(endPoint: endpoint) { (result: Result<GameModel, NetworkError>) in
            completion(result)
        }
    }
    // User Search Query
    func searchGames(endpoint: GameEndPoint, completion: @escaping (Result<GameModel, NetworkError>) -> Void) {
        manager.fetch(endPoint: endpoint) { (result: Result<GameModel, NetworkError>) in
            completion(result)
        }
    }
    // Get user selected detail
    func getDetails(endpoint: GameEndPoint, completion: @escaping (Result<GameDetailModel, NetworkError>) -> Void) {
        manager.fetch(endPoint: endpoint) { (result: Result<GameDetailModel, NetworkError>) in
            completion(result)
        }
    }
}
