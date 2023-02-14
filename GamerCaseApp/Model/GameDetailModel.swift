//
//  GameDetalModel.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/14/23.
//

import Foundation

struct GameDetailModel: Decodable, Equatable {
    let background_image: String
    let id: Int
    let name_original: String
    let description: String
    let reddit_url: String
    let website: String
}
