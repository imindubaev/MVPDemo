//
//  CoinCell.swift
//  CryptoWallet_MVP
//
//  Created by Ilnur Mindubayev on 20.11.2022.
//

import UIKit

class CoinCell: UITableViewCell {
    
    let symbol: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    let name: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    let priceUsd: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    let percentChange: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        [symbol, name, priceUsd, percentChange].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            symbol.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            symbol.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            name.topAnchor.constraint(equalTo: symbol.bottomAnchor, constant: 10),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            priceUsd.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            priceUsd.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            percentChange.topAnchor.constraint(equalTo: priceUsd.bottomAnchor, constant: 10),
            percentChange.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            percentChange.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    var coin : CoinModel? {
        didSet {
            symbol.text = coin?.data?.symbol ?? "no symbol"
            name.text = coin?.data?.name ?? "no name"
            priceUsd.text = String(format: "%.2f", coin?.data?.marketData.priceUsd ?? "no priceUSD")
            percentChange.text = String(format: "%.2f", coin?.data?.marketData.percentChangeUsdLast24_Hours ?? "no PercentChange") + " %"
        }
    }
}
