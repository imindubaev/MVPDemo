//
//  NetworkService.swift
//  CryptoWallet_MVP
//
//  Created by Ilnur Mindubayev on 20.11.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCoinModel(coinsEnum: CoinsEnum, completion: @escaping (Result<CoinModel?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getCoinModel(coinsEnum: CoinsEnum, completion: @escaping ((Result<CoinModel?, Error>) -> Void)) {

        guard let url = URL.coinInfo(forCoin: coinsEnum) else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                do {
                    let obj = try JSONDecoder().decode(CoinModel.self, from: data!)
                    completion(.success(obj))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}

extension URL {
    static func coinInfo(forCoin: CoinsEnum) -> URL? {
        URL(string: "https://data.messari.io/api/v1/assets/\(forCoin)/metrics")
    }
}
