//
//  SearchBarViewController.swift
//  MeLiMobileCandidate
//
//  Created by Marcos Bazzano on 7/8/24.
//

import Foundation
import UIKit

class SearchViewController : UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private var products: [SearchResultItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        title = "Buscar productos"
        view.backgroundColor = .white
        setupSearchbar()
        setupTableView()
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
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
// MARK: UISearchBarDelegate

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        fetchData(for: searchTerm)
    }
    
    private func fetchData(for searchTerm: String) {
            NetworkManager.shared.fetchData(for: searchTerm) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let products):
                        self?.products = products
                        self?.tableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    
// MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                let product = products[indexPath.row]
                cell.textLabel?.text = product.title
                return cell
    }
}


