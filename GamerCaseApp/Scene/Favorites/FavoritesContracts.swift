//
//  FavoritesContracts.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/18/23.
//

import Foundation

enum FavoriteOutput {
    case showEmptyView(message: String)
    case removeEmptyView
    case uploadPresentation(presentation: [FavoritesPresentation])
}
