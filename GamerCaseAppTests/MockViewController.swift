//
//  MockViewController.swift
//  GamerCaseAppTests
//
//  Created by Kaan Yeyrek on 2/20/23.
//

@testable import GamerCaseApp

final class MockViewController: HomeViewInterface {
    
    func setUI() {
        
    }
    func setNavBarTitleFeatures() {
        
    }
    func setSubviews() {
        
    }
    func setLayout() {
        
    }
    // table prepare call check
    var invokedPrepareTableView = false
    var invokedPrepareTableViewCount = 0
    
    func setTableView() {
        invokedPrepareTableView = true
        invokedPrepareTableViewCount += 1
    }
    // reload table
    var invokedReloadData = false
    var invokedReloadDataCount = 0
    
    func reloadTable() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }
    func setSearchController() {
        
    }
    // change loading parameter check
    var invokeChangeLoading = false
    var invokeChangeLoadingCount = 0
    var changeLoadingParameters: (isLoad: Bool, Void)?
    var changeLoadingParametersList = [(isLoad: Bool, Void)]()
    
    func changeLoading(isLoad: Bool) {
        invokeChangeLoading = true
        invokeChangeLoadingCount += 1
        changeLoadingParameters = (isLoad: isLoad, ())
        changeLoadingParametersList.append((isLoad: isLoad, ()))
    }
    func handleOutput(output: HomeViewModelOutput) {
        
    }
    func navigate(route: HomeViewModelRoute) {
        
    }
}

