//
//  NetworkManager.swift
//  MeLiMobileCandidate
//
//  Created by Marcos Bazzano on 7/8/24.
//

import Foundation
class NetworkManager{
    static var shared = NetworkManager(session: .shared)
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetchData(for searchTerm: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        let urlString = "https://api.mercadolibre.com/sites/MLA/search?q=\(searchTerm)"
        guard let url = URL(string: urlString) else { return }
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let results = json["results"] as? [[String: Any]] {
                    let products = results.compactMap { Product(json: $0) }
                    completion(.success(products))
                } else {
                    let error = NSError(domain: "NetworkManagerError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
