//
//  HomeDetailContracts.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/13/23.
//

import Foundation

enum HomeDetailOutput {
    case loadPresentation([HomeDetailPresentation])
    case failedUpdateData(message: String, title: String)
    case empty(message: String)
    case removeEmpty
//    case showMore(url: String)
//    case isSaved(Bool)
}
