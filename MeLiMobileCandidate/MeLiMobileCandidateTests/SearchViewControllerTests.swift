//
//  SearchViewControllerTests.swift
//  MeLiMobileCandidateTests
//
//  Created by Marcos Bazzano on 12/8/24.
//

import XCTest
@testable import MeLiMobileCandidate

class SearchViewControllerTests: XCTestCase {
    
    var searchViewController: SearchViewController!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        
        mockNetworkManager = MockNetworkManager(session: .shared)
        searchViewController = SearchViewController()
        
        NetworkManager.shared = mockNetworkManager
        
        _ = searchViewController.view
    }
    
    override func tearDown() {
        searchViewController = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testSearchBarSetup() {
        XCTAssertNotNil(searchViewController.searchBar)
        XCTAssertEqual(searchViewController.searchBar.placeholder, "Buscar productos")
        XCTAssertEqual(searchViewController.searchBar.backgroundColor, UIColor.MeLiYellow)
    }
    
    func testTableViewSetup() {
        XCTAssertNotNil(searchViewController.tableView)
        XCTAssertTrue(searchViewController.tableView.delegate === searchViewController)
        XCTAssertTrue(searchViewController.tableView.dataSource === searchViewController)
    }
    
    func testSearchBarSearchButtonClicked_EmptySearchTerm() {
        searchViewController.searchBar.text = ""
        searchViewController.searchBarSearchButtonClicked(searchViewController.searchBar)
        
        XCTAssertTrue(searchViewController.products.isEmpty)
        XCTAssertEqual(searchViewController.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func testSearchBarSearchButtonClicked_ValidSearchTerm() {
        let expectation = XCTestExpectation(description: "Completion handler called")
        
        mockNetworkManager.mockProducts = [
            Product(id: "1", title: "Product 1", price: 10.0, thumbnail: nil, availableQuantity: 5, acceptsMercadoPago: true, installmentAmount: 5.0, installmentQuantity: 2, installmentRate: 0.0),
            Product(id: "2", title: "Product 2", price: 20.0, thumbnail: nil, availableQuantity: 3, acceptsMercadoPago: true, installmentAmount: 10.0, installmentQuantity: 2, installmentRate: 0.0)
        ]
        
        searchViewController.searchBar.text = "test"
        searchViewController.searchBarSearchButtonClicked(searchViewController.searchBar)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.searchViewController.products.count, 2)
            XCTAssertEqual(self.searchViewController.tableView.numberOfRows(inSection: 0), 2)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchData_Success() {
        
    }
}

class MockNetworkManager: NetworkManager {
    
    var shouldReturnError = false
    var mockProducts: [Product] = []
    
    override func fetchData(for searchTerm: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "TestError", code: 0, userInfo: nil)))
        } else {
            completion(.success(mockProducts))
        }
    }
}
