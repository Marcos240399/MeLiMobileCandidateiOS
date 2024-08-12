//
//  ImageCarrouselCell.swift
//  MeLiMobileCandidate
//
//  Created by Marcos Bazzano on 10/8/24.
//

import Foundation
import UIKit
class ImageCarouselCell: UICollectionViewCell {
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        self.backgroundColor = .black
            
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
