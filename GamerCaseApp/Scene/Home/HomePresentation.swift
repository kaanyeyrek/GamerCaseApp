//
//  BooksPresentation.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/9/23.
//

import Foundation

struct HomePresentation {
    let id: Int
    let title: String
    let background_image: String?
    let metacritic: Int
    let genreName: [String]
    
    init(model: GameResult) {
        self.id = model.id
        self.title = model.name
        self.background_image = model.background_image
        self.metacritic = model.metacritic
        let genresArray = model.genres.map { $0.name }
        self.genreName = genresArray
    }
}
