//
//  GameModel.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/9/23.
//

import Foundation

struct GameModel: Decodable {
    let results: [GameResult]
}
struct GameResult: Decodable, Equatable {
    let id: Int
    let name: String
    let background_image: String
    let metacritic: Int
    let genres: [Genre]
}
struct Genre: Decodable, Equatable {
    let id: Int
    let name: String
}
