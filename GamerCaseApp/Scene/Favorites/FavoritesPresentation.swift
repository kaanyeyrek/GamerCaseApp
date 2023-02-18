//
//  FavoritesPresentation.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/18/23.
//

import Foundation

struct FavoritesPresentation {
    let name: String
    let gameImage: String?
    let metaCriticCount: Int
    let genres: [String]
    let id: String
    
    init(model: Games) {
        self.name = model.name!
        self.gameImage = model.image
        self.metaCriticCount = Int(model.metacritic)
        self.genres = model.genre as! [String]
        self.id = model.id ?? ""
    }
}
