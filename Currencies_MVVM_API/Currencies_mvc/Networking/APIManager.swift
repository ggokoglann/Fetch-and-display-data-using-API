//
//  APIManager.swift
//  Currencies_mvc
//
//  Created by Gökhan Gökoğlan on 13.07.2023.
//

import Foundation
import UIKit

class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    func fetchCurrencies(completion: @escaping ([Currency]?, Error?) -> Void) {
        guard let url = URL(string: "https://api.genelpara.com/embed/doviz.json") else {
            completion(nil, APIError.invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, APIError.invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let currenciesData = try decoder.decode([String: CurrencyData].self, from: data)
                
                let desiredOrder = ["USD", "EUR", "GBP", "BTC", "ETH", "GA"]
                
                let currencies = desiredOrder.compactMap { currencyCode -> Currency? in
                    guard let currencyData = currenciesData[currencyCode] else {
                        return nil
                    }
                    
                    return Currency(name: currencyCode,
                                    price: Float(currencyData.satis) ?? 0.0,
                                    image: UIImage(named: "\(currencyCode).png") ?? UIImage())
                }
                
                completion(currencies, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}

struct CurrencyData: Codable {
    let satis: String
}

enum APIError: Error {
    case invalidURL
    case invalidData
}
