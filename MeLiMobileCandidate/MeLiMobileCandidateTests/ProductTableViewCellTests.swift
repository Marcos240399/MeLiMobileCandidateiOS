//
//  SearchResultTableViewCell.swift
//  MeLiMobileCandidateTests
//
//  Created by Marcos Bazzano on 12/8/24.
//

import XCTest
@testable import MeLiMobileCandidate

class SearchResultTableViewCellTests: XCTestCase {

    var cell: ProductTableViewCell!

    override func setUpWithError() throws {
        try super.setUpWithError()
        cell = ProductTableViewCell(style: .default, reuseIdentifier: "ProductCell")
    }

    override func tearDownWithError() throws {
        cell = nil
        try super.tearDownWithError()
    }

    func testConfigureWithProduct() {
        let image = UIImage(named: "placeholder")
        let product = Product(id: "1", title: "Test Product", price: 19.99, thumbnail: image, availableQuantity: 10, acceptsMercadoPago: true, installmentAmount: 6, installmentQuantity: 3, installmentRate: 0)
        cell.configure(with: product)
        XCTAssertEqual(cell.titleLabel.text, product.title, "Title label text should match product title")
        XCTAssertEqual(cell.priceLabel.text, "$19.99", "Price label text should be correctly formatted")
        XCTAssertEqual(cell.thumbnailImageView.image, image, "Thumbnail image should match the product's thumbnail")
    }

    func testPriceFormattingRemovesTrailingZeroes() {
        let image = UIImage(named: "placeholder")
        let product = Product(id: "1", title: "Test Product", price: 19.00, thumbnail: image, availableQuantity: 10, acceptsMercadoPago: true, installmentAmount: 6.66, installmentQuantity: 3, installmentRate: 0)
        
        cell.configure(with: product)
        
        XCTAssertEqual(cell.priceLabel.text, "$19", "Price label text should remove trailing zeroes")
    }

    func testPriceFormattingKeepsTwoDecimalPlacesWhenNecessary() {
        let image = UIImage(named: "placeholder")
        let product = Product(id: "1", title: "Test Product", price: 19.98, thumbnail: image, availableQuantity: 10, acceptsMercadoPago: true, installmentAmount: 9.99, installmentQuantity: 2, installmentRate: 0)
        cell.configure(with: product)
        XCTAssertEqual(cell.priceLabel.text, "$19.98", "Price label text should keep two decimal places when necessary")
    }

    func testCellSubviewsAreCorrectlyConfigured() {
        XCTAssertNotNil(cell.thumbnailImageView, "Thumbnail image view should be initialized")
        XCTAssertNotNil(cell.titleLabel, "Title label should be initialized")
        XCTAssertNotNil(cell.priceLabel, "Price label should be initialized")
    }
}

