//
//  Installments.swift
//  MeLiMobileCandidate
//
//  Created by Marcos Bazzano on 11/8/24.
//

import Foundation
import UIKit

class Installments {

    var quantity: Int
    var price: Float
    var rate: Float
    
    init(quantity: Int, price: Float, rate: Float) {
        self.price = price
        self.quantity = quantity
        self.rate = rate
    }
}
