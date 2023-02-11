//
//  HomeContracts.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/9/23.
//

import Foundation

enum HomeViewModelOutput {
    case failedUpdateData(message: String, title: String)
    case uploadPresentation(presentation: [HomePresentation])
    case empty(message: String)
    case removeEmpty
}
enum HomeViewModelRoute {
}
