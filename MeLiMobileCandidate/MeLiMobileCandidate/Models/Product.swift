//
//  Product.swift
//  MeLiMobileCandidate
//
//  Created by Marcos Bazzano on 7/8/24.
//
import Foundation
import UIKit

class Product {
    var id: String
    var title: String
    var price: Float
    var thumbnail: UIImage?
    var availableQuantity: Int
    var acceptsMercadoPago: Bool
    var installmentAmount: Double
    var installmentRate: Double
    var installmentQuantity: Int
    
    init(id: String, title: String, price: Float, thumbnail: UIImage?, availableQuantity: Int, acceptsMercadoPago: Bool, installmentAmount: Double, installmentQuantity: Int, installmentRate: Double) {
        self.id = id
        self.title = title
        self.price = price
        self.thumbnail = thumbnail
        self.availableQuantity = availableQuantity
        self.acceptsMercadoPago = acceptsMercadoPago
        self.installmentAmount = installmentAmount
        self.installmentRate = installmentRate
        self.installmentQuantity = installmentQuantity
    }
    
    convenience init?(json: [String: Any]) {
        guard let id = json["id"] as? String,
              let title = json["title"] as? String,
              let price = json["price"] as? Float,
              let thumbnailURLString = json["thumbnail"] as? String,
              let thumbnailURL = URL(string: thumbnailURLString),
              let thumbnailData = try? Data(contentsOf: thumbnailURL),
              let availableQ = json["available_quantity"] as? Int,
              let mercadoPago = json["accepts_mercadopago"] as? Bool,
              let installment = json["installments"] as? [String: Any],
              let installmentAmount = installment["amount"] as? Double,
              let installmentRate = installment["rate"] as? Double,
              let installmentQuantity = installment["quantity"] as? Int,
              let thumbnailImage = UIImage(data: thumbnailData)
        else {
            return nil
        }
        self.init(id: id, title: title, price: price, thumbnail: thumbnailImage, availableQuantity: availableQ, acceptsMercadoPago: mercadoPago, installmentAmount: installmentAmount, installmentQuantity: installmentQuantity, installmentRate: installmentRate)
    }
}
