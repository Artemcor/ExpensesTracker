//
//  ApiService.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 02.10.2022.
//

import Foundation

typealias BitcoinRateSuccess = (_ bitcoinRate: BitcoinRate) -> Void

class APIService {
    
    static func getBitcoinRate(success: BitcoinRateSuccess?) {
        let bitcoinRateUrlStr = "https://api.coindesk.com/v1/bpi/currentprice.json"
        
        guard let bitcoinRateUrl = URL(string: bitcoinRateUrlStr) else {
            fatalError("Error: Invalid URL.")
        }
        
        let request = URLRequest(url: bitcoinRateUrl)
        
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
            guard let data = data else {
                fatalError("Error: Data is corrupt.")
            }
            
            do {
                let data = try JSONDecoder().decode(BitcoinRate.self, from: data)
                if let success = success {
                    success(data)
                }
            } catch let error {
                print(String(describing: error))
            }
        }
        session.resume()
    }
}
