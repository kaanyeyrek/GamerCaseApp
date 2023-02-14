//
//  HomeDetailPresentation.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/14/23.
//

import Foundation

struct HomeDetailPresentation {
    let id: Int
    let name_original: String
    let description: String
    let reddit_url: String
    let website: String
    let background_image: String?
    
    init(model: GameDetailModel) {
        self.id = model.id
        self.name_original = model.name_original
        self.description = model.description
        self.reddit_url = model.reddit_url
        self.website = model.website
        self.background_image = model.background_image
        
    }
}
