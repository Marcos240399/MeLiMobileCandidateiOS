//
//  SearchBarViewController.swift
//  MeLiMobileCandidate
//
//  Created by Marcos Bazzano on 7/8/24.
//

import Foundation
import UIKit

class SearchViewController : UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    internal let searchBar = UISearchBar()
    internal let tableView = UITableView()
    internal var products: [Product] = []
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .blue
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        title = "Buscar productos"
        view.backgroundColor = .MeLiYellow
        
        setupSearchbar()
        setupTableView()
        setupActivityIndicator()

    }
    
    private func setupSearchbar(){
        searchBar.delegate = self
        searchBar.placeholder = "Buscar productos"
        searchBar.backgroundColor = UIColor.MeLiYellow
        searchBar.barTintColor = UIColor.MeLiYellow
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupTableView(){
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        products = []
        tableView.reloadData()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {
            self.showAlertMessage(title: "Busqueda incorrecta", message: "La busqueda no puede ser vacía")
            print("BusquedaVacía")
            return
        }
        fetchData(for: searchTerm)
    }
    
    private func fetchData(for searchTerm: String) {
        activityIndicator.startAnimating()
        NetworkManager.shared.fetchData(for: searchTerm) { [weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                switch result {
                case .success(let products):
                    self?.products = products
                    if products.isEmpty {
                        self?.showAlertMessage(title: "Error", message: "No se encontraron resultados para la busqueda")
                        print("404: No se encontraron resultados para la busqueda")
                    }
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = products[indexPath.row]
        let detailVC = ProductDetailViewController(product: selectedProduct)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        let item = products[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
}


extension UIViewController{
    
    public func showAlertMessage(title: String, message: String){
        
        let alertMessagePopUpBox = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        
        alertMessagePopUpBox.addAction(okButton)
        self.present(alertMessagePopUpBox, animated: true)
    }
}
