//
//  HomeDetailContracts.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/13/23.
//

import Foundation

enum HomeDetailOutput {
    case loadPresentation(HomePresentation)
    case showMore(url: String)
    case isSaved(Bool)
}
