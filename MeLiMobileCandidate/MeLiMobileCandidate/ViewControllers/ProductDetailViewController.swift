//
//  ProductDetailViewController.swift
//  MeLiMobileCandidate
//
//  Created by Marcos Bazzano on 8/8/24.
//

import Foundation
import UIKit

class ProductDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    internal var product: Product
    internal var images: [UIImage] = []
    
    internal let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal var carrouselView: UICollectionView!
    internal let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        return pageControl
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let spacerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLeadingBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    internal let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal let mercadoPagoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    internal let mercadoPagoIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    internal let stockLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal let installmentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureViewWithProduct()
    }
    
    private func setupViews() {
        view.backgroundColor = .MeLiYellow
        view.addSubview(titleLabel)
        view.addSubview(titleLeadingBackgroundView)
        view.addSubview(spacerView)
        view.addSubview(backgroundView)
        view.addSubview(pageControl)
        view.addSubview(priceLabel)
        view.addSubview(mercadoPagoLabel)
        view.addSubview(mercadoPagoIcon)
        view.addSubview(stockLabel)
        view.addSubview(installmentsLabel)
        setupCarrouselView()
        view.addSubview(carrouselView)
        
        titleLabel.backgroundColor = .white
        titleLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleLeadingBackgroundView.trailingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([spacerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
                                     spacerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     spacerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     spacerView.heightAnchor.constraint(equalToConstant: 10)])
        
        
        NSLayoutConstraint.activate([titleLeadingBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     titleLeadingBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     titleLeadingBackgroundView.bottomAnchor.constraint(equalTo: spacerView.topAnchor),
                                     titleLeadingBackgroundView.widthAnchor.constraint(equalToConstant: 16)])
        
        NSLayoutConstraint.activate([
            carrouselView.topAnchor.constraint(equalTo: spacerView.bottomAnchor),
            carrouselView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carrouselView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carrouselView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: carrouselView.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: carrouselView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            mercadoPagoIcon.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 16),
            mercadoPagoIcon.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            mercadoPagoIcon.widthAnchor.constraint(equalToConstant: 50),
            mercadoPagoIcon.heightAnchor.constraint(equalToConstant: 50),
            
            mercadoPagoLabel.leadingAnchor.constraint(equalTo: mercadoPagoIcon.trailingAnchor, constant: 8),
            mercadoPagoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mercadoPagoLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stockLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            stockLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stockLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            installmentsLabel.topAnchor.constraint(equalTo: stockLabel.bottomAnchor, constant: 8),
            installmentsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            installmentsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupCarrouselView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: 300)
        layout.minimumLineSpacing = 0
        
        carrouselView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        carrouselView.dataSource = self
        carrouselView.delegate = self
        carrouselView.isPagingEnabled = true
        carrouselView.showsHorizontalScrollIndicator = false
        carrouselView.translatesAutoresizingMaskIntoConstraints = false
        carrouselView.register(ImageCarouselCell.self, forCellWithReuseIdentifier: "ImageCarouselCell")
        carrouselView.backgroundColor = .white
        pageControl.numberOfPages = images.count
    }
    
    private func configureViewWithProduct() {
        titleLabel.text = product.title
        priceLabel.text = "$" + RemoveTrailingZeroes(from: product.price)
        mercadoPagoLabel.text = "Disponible"
        mercadoPagoIcon.image = UIImage(named: "MercadoPagoIcon")
        stockLabel.text = String(product.availableQuantity) + " en stock"
        let installmentQuantityText = RemoveTrailingZeroes(from: product.installmentQuantity)
        let installmentAmountText = "$" + RemoveTrailingZeroes(from: product.installmentAmount)
        installmentsLabel.text = "en " + installmentQuantityText + "x " + installmentAmountText
        if product.installmentRate == 0 { installmentsLabel.text! += " sin intereses!" }
        installmentsLabel.textColor = .InstallmentGreen
        if product.acceptsMercadoPago == false{
            mercadoPagoLabel.isHidden = true
            mercadoPagoIcon.isHidden = true
        }
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCarouselCell", for: indexPath) as! ImageCarouselCell
        cell.imageView.image = images[indexPath.item]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
    }
    
    init(product: Product) {
        self.product = product
        if let thumbnail = product.thumbnail {
            for _ in 1...3 {
                images.append(thumbnail)
            }
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func RemoveTrailingZeroes(from number: Double) -> String{
        var stringifiedInput = String(format: "%.2f", number)
        if((stringifiedInput.contains(where: { Character in
            Character == "."
        }))){
            let split = stringifiedInput.components(separatedBy: ".")
            if(split[1].allSatisfy({ Character in
                Character == "0"
            })){
                stringifiedInput = split[0]
            }
        }
        return stringifiedInput
    }
}

