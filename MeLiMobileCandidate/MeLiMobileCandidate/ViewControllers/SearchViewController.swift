//
//  SearchBarViewController.swift
//  MeLiMobileCandidate
//
//  Created by Marcos Bazzano on 7/8/24.
//

import Foundation
import UIKit

class SearchViewController : UIViewController, UISearchBarDelegate {
    
    private let searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        title = "Buscar productos"
        view.backgroundColor = .white
        setupSearchbar()
    }
    
    private func setupSearchbar(){
        searchBar.delegate = self
        searchBar.placeholder = "Buscar productos"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    
}
