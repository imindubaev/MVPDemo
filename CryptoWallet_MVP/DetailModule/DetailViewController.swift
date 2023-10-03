//
//  DetailViewController.swift
//  CryptoWallet_MVP
//
//  Created by Ilnur Mindubayev on 21.11.2022.
//

import UIKit

class DetailViewController: UIViewController {

    var presenter: DetailViewPresenterProtocol!
    
    private let symbolLabel = UILabel()
    private let nameLabel = UILabel()
    private let priceUsdLabel = UILabel()
    private let percentChangeLabel = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // symbolLabel setup
        view.addSubview(symbolLabel)
        symbolLabel.text = "symbolLabel"
        symbolLabel.textAlignment = .center
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        symbolLabel.font = UIFont.systemFont(ofSize: 34.0)
        
        // nameLabel setup
        view.addSubview(nameLabel)
        nameLabel.text = "nameLabel"
        nameLabel.textAlignment = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // priceUsdLabel setup
        view.addSubview(priceUsdLabel)
        priceUsdLabel.text = "priceUsdLabel"
        priceUsdLabel.textAlignment = .left
        priceUsdLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // percentChangeLabel
        view.addSubview(percentChangeLabel)
        percentChangeLabel.text = "percentChangeLabel"
        percentChangeLabel.textAlignment = .left
        percentChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            symbolLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            symbolLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            symbolLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            priceUsdLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            priceUsdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            percentChangeLabel.topAnchor.constraint(equalTo: priceUsdLabel.bottomAnchor, constant: 20),
            percentChangeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        presenter.setCoinModelDetailedInfo()
        
    }
}

extension DetailViewController: DetailViewProtocol {
    func setCoinModelDetailedInfo(coinModel: CoinModel?) {
        symbolLabel.text = coinModel?.data?.symbol ?? "no symbol"
        nameLabel.text = coinModel?.data?.name ?? "no name"
        priceUsdLabel.text = String(format: "%.2f", coinModel?.data?.marketData.priceUsd ?? "no priceUSD")
        percentChangeLabel.text = String(format: "%.2f", coinModel?.data?.marketData.percentChangeUsdLast24_Hours ?? "no PercentChange")
    }
}
