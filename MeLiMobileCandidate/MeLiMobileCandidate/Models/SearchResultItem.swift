//
//  SearchResultItem.swift
//  MeLiMobileCandidate
//
//  Created by Marcos Bazzano on 7/8/24.
//
import Foundation
import UIKit

class SearchResultItem {
    var id: String
    var title: String
    var price: Float
    var thumbnail: UIImage?

    init(id: String, title: String, price: Float, thumbnail: UIImage?) {
        self.id = id
        self.title = title
        self.price = price
        self.thumbnail = thumbnail
    }

    convenience init?(json: [String: Any]) {
        guard let id = json["id"] as? String,
              let title = json["title"] as? String,
              let price = json["price"] as? Float,
              let thumbnailURLString = json["thumbnail"] as? String,
              let thumbnailURL = URL(string: thumbnailURLString),
              let thumbnailData = try? Data(contentsOf: thumbnailURL),
              let thumbnailImage = UIImage(data: thumbnailData) else {
            return nil
        }

        self.init(id: id, title: title, price: price, thumbnail: thumbnailImage)
    }
}
