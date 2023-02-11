//
//  GameEndpoint.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/9/23.
//

import Foundation

enum GameEndPoint: HTTPEndPoint {
    case fetchGames(size: Int, page: Int)
    case searchGames(size: Int, query: String, page: Int)
    
    var path: String {
        return Paths.games
    }
    var query: [URLQueryItem] {
        switch self {
        case .fetchGames(let size, let page):
            return [URLQueryItem(name: "key", value: NetworkHelper.apiKey),
                    URLQueryItem(name: "page_size", value: String(size)),
                    URLQueryItem(name: "page", value: String(page)),
            ]
        case .searchGames(let size, let query, let page):
            return [URLQueryItem(name: "key", value: NetworkHelper.apiKey),
                    URLQueryItem(name: "page_size", value: String(size)),
                    URLQueryItem(name: "page", value: String(page)),
                    URLQueryItem(name: "search", value: query)
            ]
        }
    }
}
