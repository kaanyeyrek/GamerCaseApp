//
//  DetailBuilder.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/13/23.
//

import Foundation
// helper builder
final class DetailBuilder {
    static func make(viewModel: HomeDetailViewModelImterface) -> HomeDetailViewController {
        let vc = HomeDetailViewController(viewModel: viewModel)
        return vc
    }
}
