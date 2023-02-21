//
//  MockGameService.swift
//  GamerCaseAppTests
//
//  Created by Kaan Yeyrek on 2/20/23.
//

@testable import GamerCaseApp

final class MockGameService: GameServiceInterface {
    
    var shouldReturnError = false
    var isFetchGamesCalled = false
    var isFetchGamesCount = 0
    
    func fetchGames(endpoint: GameEndPoint, completion: @escaping (Result<GameModel, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(NetworkError.badResponse))
        } else {
            let mockGameModel = GameModel(results: [GameResult(id: 1, name: "mock games", background_image: "", metacritic: 1, genres: [])])
            isFetchGamesCalled = true
            isFetchGamesCount += 1
            completion(.success(mockGameModel))
        }
    }
    func searchGames(endpoint: GameEndPoint, completion: @escaping (Result<GameModel, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(NetworkError.badResponse))
               } else {
                   let mockGameModel = GameModel(results: [GameResult(id: 1, name: "mock search", background_image: "", metacritic: 2, genres: [])])
                   completion(.success(mockGameModel))
               }
    }
    func getDetails(endpoint: GameEndPoint, completion: @escaping (Result<GameDetailModel, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(NetworkError.badResponse))
        } else {
            let mockGameModel = GameDetailModel(background_image: "", id: 3, name_original: "", description: "", reddit_url: "", website: "")
            completion(.success(mockGameModel))
        }
    }
}
