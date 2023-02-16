//
//  DetailBuilder.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/13/23.
//

import Foundation
// helper builder navigate detail vc 
@available(iOS 13.0, *)
final class DetailBuilder {
    static func make(viewModel: HomeDetailViewModelInterface) -> HomeDetailViewController {
        let vc = HomeDetailViewController(viewModel: viewModel)
        return vc
    }
}
