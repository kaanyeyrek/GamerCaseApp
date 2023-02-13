//
//  HomeDetailViewController.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/13/23.
//

import UIKit

protocol HomeDetailViewInterface: AnyObject {
    func setUI()
    func handleOutput(output: HomeDetailOutput)
}

final class HomeDetailViewController: UIViewController {
//MARK: - Injections
    private var viewModel: HomeDetailViewModelImterface!
//MARK: - Global UI Elements
    
    init(viewModel: HomeDetailViewModelImterface!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
}
//MARK: - HomeDetailInterface Methods
extension HomeDetailViewController: HomeDetailViewInterface {
    func setUI() {
        view.backgroundColor = .systemBackground
    }
    func handleOutput(output: HomeDetailOutput) {
       
    }
}
