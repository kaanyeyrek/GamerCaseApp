//
//  GameEndpoint.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/9/23.
//

import Foundation

enum GameEndPoint: HTTPEndPoint {
    // Endpoint Case
    case fetchGames(size: Int, page: Int)
    case searchGames(size: Int, search: String, page: Int)
    case getDetail(id: Int)
    // Network Path
    var path: String {
        switch self {
            case .getDetail(let id):
            return "/api/games/\(id)"
        case .fetchGames:
            return Paths.games
        case .searchGames:
            return Paths.games
        }
    }
    // Network URL Query
    var query: [URLQueryItem] {
        switch self {
        case .fetchGames(let size, let page):
            return [URLQueryItem(name: "key", value: NetworkHelper.apiKey),
                    URLQueryItem(name: "page_size", value: String(size)),
                    URLQueryItem(name: "page", value: String(page)),
            ]
        case .searchGames(let size, let search, let page):
            return [URLQueryItem(name: "key", value: NetworkHelper.apiKey),
                    URLQueryItem(name: "page_size", value: String(size)),
                    URLQueryItem(name: "page", value: String(page)),
                    URLQueryItem(name: "search", value: search)
            ]
        case .getDetail(_):
            return [URLQueryItem(name: "key", value: NetworkHelper.apiKey)
            ]
        }
    }
}
