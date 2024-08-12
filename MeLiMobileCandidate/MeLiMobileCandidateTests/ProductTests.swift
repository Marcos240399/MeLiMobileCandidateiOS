//
//  ProductTests.swift
//  MeLiMobileCandidateTests
//
//  Created by Marcos Bazzano on 12/8/24.
//

import XCTest
@testable import MeLiMobileCandidate

class ProductTests: XCTestCase {

    func testProductInitialization() {
        let product = Product(id: "1",
                              title: "Product 1",
                              price: 10.0,
                              thumbnail: UIImage(),
                              availableQuantity: 5,
                              acceptsMercadoPago: true,
                              installmentAmount: 12.0,
                              installmentQuantity: 2,
                              installmentRate: 0.0)
        
        XCTAssertNotNil(product)
        XCTAssertEqual(product.id, "1")
        XCTAssertEqual(product.title, "Product 1")
        XCTAssertEqual(product.price, 10.0)
        XCTAssertEqual(product.availableQuantity, 5)
        XCTAssertTrue(product.acceptsMercadoPago)
        XCTAssertEqual(product.installmentAmount, 12.0)
        XCTAssertEqual(product.installmentQuantity, 2)
        XCTAssertEqual(product.installmentRate, 0.0)
    }

    func testProductInitializationWithInvalidData() {
        let product = Product(id: "",
                              title: "",
                              price: -10.0,
                              thumbnail: nil,
                              availableQuantity: -1,
                              acceptsMercadoPago: false,
                              installmentAmount: -12.0,
                              installmentQuantity: -2,
                              installmentRate: -1.0)
        
        XCTAssertNotNil(product)
        XCTAssertEqual(product.id, "")
        XCTAssertEqual(product.title, "")
        XCTAssertEqual(product.price, -10.0)
        XCTAssertEqual(product.availableQuantity, -1)
        XCTAssertFalse(product.acceptsMercadoPago)
        XCTAssertEqual(product.installmentAmount, -12.0)
        XCTAssertEqual(product.installmentQuantity, -2)
        XCTAssertEqual(product.installmentRate, -1.0)
    }

    func testProductConvenienceInitWithValidJSON() {
        let json: [String: Any] = [
            "id": "1",
            "title": "Product 1",
            "price": 10.0,
            "thumbnail": "http://mla-s1-p.mlstatic.com/943469-MLA31002769183_062019-I.jpg",
            "available_quantity": 5,
            "accepts_mercadopago": true,
            "installments": [
                "amount": 12.0,
                "rate": 0,
                "quantity": 2
            ]
        ]
        
        let product = Product(json: json)
        
        XCTAssertNotNil(product)
        XCTAssertEqual(product?.id, "1")
        XCTAssertEqual(product?.title, "Product 1")
        XCTAssertEqual(product?.price, 10.0)
        XCTAssertEqual(product?.availableQuantity, 5)
        XCTAssertTrue(product?.acceptsMercadoPago ?? false)
        XCTAssertEqual(product?.installmentAmount, 12.0)
        XCTAssertEqual(product?.installmentQuantity, 2)
        XCTAssertEqual(product?.installmentRate, 0.0)
    }

    func testProductConvenienceInitWithInvalidJSON() {
        let json: [String: Any] = [
            "id": "1",
            "title": "Product 1",
        ]
        
        let product = Product(json: json)
        
        XCTAssertNil(product)
    }
}
