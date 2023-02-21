//
//  GamerCaseAppTests.swift
//  GamerCaseAppTests
//
//  Created by Kaan Yeyrek on 2/9/23.
//

import XCTest
@testable import GamerCaseApp

final class GamerCaseAppTests: XCTestCase {

    private var viewModel: HomeViewModel!
    private var view: MockViewController!
    private var mockService: MockGameService!
    
    override func setUp() {
        super.setUp()
        view = .init()
        mockService = MockGameService()
        viewModel = .init(view: view, service: mockService)
    }
    override func tearDown() {
        super.tearDown()
        view = nil
        viewModel = nil
        mockService = nil
    }
    func test_model_ReturnArray() {
        XCTAssertEqual(viewModel.model, .init())
    }
    func test_fetch_Games() {
        mockService.shouldReturnError = false
               let expectation = self.expectation(description: "Completion should be called")
        
        mockService.fetchGames(endpoint: .fetchGames(size: 10, page: 1), completion: { result in
                   switch result {
                   case .success(let gameModel):
                       // Do your assertions on gameModel here
                       XCTAssertNotNil(gameModel)
                   case .failure(_):
                       XCTFail("Should not return an error")
                   }
                   expectation.fulfill()
               })
               
               waitForExpectations(timeout: 1.0, handler: nil)
        }
    func test_search_Games() {
           mockService.shouldReturnError = false
           let expectation = self.expectation(description: "Completion should be called")
    
           mockService.searchGames(endpoint: .searchGames(size: 10, search: "Gta", page: 1), completion: { result in
               switch result {
               case .success(let gameModel):
                   // Do your assertions on gameModel here
                   XCTAssertNotNil(gameModel)
               case .failure(_):
                   XCTFail("Should not return an error")
               }
               expectation.fulfill()
           })
           waitForExpectations(timeout: 1.0, handler: nil)
       }
    func test_get_Details() {
            mockService.shouldReturnError = false
            let expectation = self.expectation(description: "Completion should be called")
            
        mockService.getDetails(endpoint: .getDetail(id: 3498), completion: { result in
                switch result {
                case .success(let gameDetailModel):
                    // Do your assertions on gameDetailModel here
                    XCTAssertNotNil(gameDetailModel)
                case .failure(_):
                    XCTFail("Should not return an error")
                }
                expectation.fulfill()
            })
            waitForExpectations(timeout: 1.0, handler: nil)
        }
    func test_viewDidLoad_InvokesRequiredMethods() {
        // given
        XCTAssertFalse(view.invokedPrepareTableView)
        XCTAssertFalse(mockService.isFetchGamesCalled)
        XCTAssertTrue(view.changeLoadingParametersList.isEmpty)
        XCTAssertFalse(view.invokeChangeLoading)
        XCTAssertFalse(view.invokedReloadData)
        // when
        viewModel.viewDidLoad()
        // then
        XCTAssertEqual(view.invokedPrepareTableViewCount, 1)
        XCTAssertEqual(mockService.isFetchGamesCount, 1)
        XCTAssertEqual(view.changeLoadingParametersList.map(\.isLoad), [true])
        XCTAssertEqual(view.invokeChangeLoadingCount, 1)
  }
}
   



