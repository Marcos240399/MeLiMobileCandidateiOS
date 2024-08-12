//
//  ProductDetailViewControllerTests.swift
//  MeLiMobileCandidateTests
//
//  Created by Marcos Bazzano on 12/8/24.
//

import Foundation

import XCTest
@testable import MeLiMobileCandidate

class ProductDetailViewControllerTests: XCTestCase {
    
    var product: Product!
    var viewController: ProductDetailViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        product = Product(id: "123",
                          title: "Test Product",
                          price: 99.99,
                          thumbnail: UIImage(named: "MercadoPagoIcon"),
                          availableQuantity: 10,
                          acceptsMercadoPago: true,
                          installmentAmount: 33.33,
                          installmentQuantity: 3,
                          installmentRate: 0)
        
        viewController = ProductDetailViewController(product: product)
        _ = viewController.view
    }
    
    override func tearDownWithError() throws {
        product = nil
        viewController = nil
        try super.tearDownWithError()
    }
    
    func testViewControllerInitialization() {
        XCTAssertNotNil(viewController, "The view controller should not be nil")
        XCTAssertEqual(viewController.product.id, product.id, "The product ID should match")
    }
    
    func testViewControllerViewConfiguration() {
        XCTAssertEqual(viewController.titleLabel.text, product.title, "The title label should display the product title")
        XCTAssertEqual(viewController.priceLabel.text, "$99.99", "The price label should display the product price")
        XCTAssertEqual(viewController.mercadoPagoLabel.text, "Disponible", "The Mercado Pago label should display 'Disponible'")
        XCTAssertEqual(viewController.stockLabel.text, "10 en stock", "The stock label should display the correct stock quantity")
        XCTAssertEqual(viewController.installmentsLabel.text, "en 3x $33.33 sin intereses!", "The installments label should display the correct installment information")
        XCTAssertFalse(viewController.mercadoPagoIcon.isHidden, "The Mercado Pago icon should be visible")
    }
    
    func testCollectionViewDataSource() {
        XCTAssertEqual(viewController.collectionView(viewController.carrouselView, numberOfItemsInSection: 0), 3, "The collection view should display the correct number of images")
        
        let cell = viewController.collectionView(viewController.carrouselView, cellForItemAt: IndexPath(item: 0, section: 0)) as! ImageCarouselCell
        XCTAssertEqual(cell.imageView.image, product.thumbnail, "The collection view cell should display the correct image")
    }
    
    func testPageControlUpdatesOnScroll() {
        viewController.view.frame = CGRect(x: 0, y: 0, width: 430, height: 932)  // iPhone 15 size
        
        viewController.view.layoutIfNeeded()
        
        viewController.carrouselView.setContentOffset(CGPoint(x: viewController.view.frame.width, y: 0), animated: false)
        viewController.scrollViewDidScroll(viewController.carrouselView)
        
        XCTAssertEqual(viewController.pageControl.currentPage, 1, "The page control should update to the correct page index")
    }
}
