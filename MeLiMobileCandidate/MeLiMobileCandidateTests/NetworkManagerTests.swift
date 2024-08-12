//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by Marcos Bazzano on 12/8/24.
//

import XCTest
@testable import MeLiMobileCandidate

class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager!
    var sessionMock: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        sessionMock = URLSessionMock()
        networkManager = NetworkManager(session: sessionMock)
    }
    
    func testFetchData_Success() {
        let jsonString = """
                {
                "results":[
                {
                           "id": "MLA811601010",
                           "title": "Samsung Galaxy J4+ Dual Sim 32 Gb Negro (2 Gb Ram)",
                           "price": 19609,
                           "available_quantity": 1,
                           "thumbnail": "http://mla-s1-p.mlstatic.com/943469-MLA31002769183_062019-I.jpg",
                           "accepts_mercadopago": true,
                           "installments": {
                               "quantity": 6,
                               "amount": 3268.17,
                               "rate": 0,
                           }
                },
                {
                           "id": "MLA816019440",
                           "title": "Apple iPhone Xr Dual Sim 128 Gb Blanco",
                           "price": 79470,
                           "available_quantity": 1,
                           "thumbnail": "http://mla-s1-p.mlstatic.com/980849-MLA31002261498_062019-I.jpg",
                           "accepts_mercadopago": true,
                           "installments": {
                               "quantity": 12,
                               "amount": 10845.67,
                               "rate": 63.77,
                           }
                }
                ]
                }
                """
        sessionMock.data = jsonString.data(using: .utf8)
        sessionMock.response = HTTPURLResponse(url: URL(string: "https://api.mercadolibre.com")!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
        sessionMock.error = nil
        
        let expectation = XCTestExpectation(description: "Completion handler called")
        
        networkManager.fetchData(for: "test") { result in
            switch result {
            case .success(let products):
                XCTAssertEqual(products.count, 2)
                XCTAssertEqual(products.first?.id, "MLA811601010")
                XCTAssertEqual(products.last?.title, "Apple iPhone Xr Dual Sim 128 Gb Blanco")
            case .failure(let error):
                XCTFail("Expected success, but got failure with error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchData_Failure() {
        sessionMock.data = nil
        sessionMock.response = nil
        sessionMock.error = NSError(domain: "Test", code: 1, userInfo: nil)
        
        let expectation = XCTestExpectation(description: "Completion handler called")
        
        networkManager.fetchData(for: "test") { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}


class URLSessionMock: URLSession {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskMock()
        task.completionHandler = {
            completionHandler(self.data, self.response, self.error)
        }
        return task
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    var completionHandler: (() -> Void)?
    
    override func resume() {
        completionHandler?()
    }
}
