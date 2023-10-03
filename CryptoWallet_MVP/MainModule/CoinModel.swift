//
//  CoinModel.swift
//  CryptoWallet_MVP
//
//  Created by Ilnur Mindubayev on 20.11.2022.
//

import Foundation

struct CoinModel: Decodable {
    let status: Status?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Decodable {
    let id: String?
    let serialID: Int?
    let symbol, name, slug: String?
    let marketData: MarketData

    enum CodingKeys: String, CodingKey {
        case id
        case serialID = "serial_id"
        case symbol, name, slug
        case marketData = "market_data"

    }
}

// MARK: - AllTimeHigh
struct AllTimeHigh: Decodable {
    let price: Double?
    let at: Date?
    let daysSince: Int?
    let percentDown, breakevenMultiple: Double?

    enum CodingKeys: String, CodingKey {
        case price, at
        case daysSince = "days_since"
        case percentDown = "percent_down"
        case breakevenMultiple = "breakeven_multiple"
    }
}

// MARK: - CycleLow
struct CycleLow: Decodable {
    let price: Double?
    let at: Date?
    let percentUp: Double?
    let daysSince: Int?

    enum CodingKeys: String, CodingKey {
        case price, at
        case percentUp = "percent_up"
        case daysSince = "days_since"
    }
}



// MARK: - MarketData
struct MarketData: Decodable {
    let priceUsd: Double?
    let priceBtc: Double?
    let priceEth, volumeLast24_Hours, realVolumeLast24_Hours, volumeLast24_HoursOverstatementMultiple: Double?
    let percentChangeUsdLast24_Hours, percentChangeBtcLast24_Hours, percentChangeEthLast24_Hours: Double?

    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case priceBtc = "price_btc"
        case priceEth = "price_eth"
        case volumeLast24_Hours = "volume_last_24_hours"
        case realVolumeLast24_Hours = "real_volume_last_24_hours"
        case volumeLast24_HoursOverstatementMultiple = "volume_last_24_hours_overstatement_multiple"
        case percentChangeUsdLast24_Hours = "percent_change_usd_last_24_hours"
        case percentChangeBtcLast24_Hours = "percent_change_btc_last_24_hours"
        case percentChangeEthLast24_Hours = "percent_change_eth_last_24_hours"
    }
}


// MARK: - Marketcap
struct Marketcap: Decodable {
    let rank: Int?
    let marketcapDominancePercent, currentMarketcapUsd, y2050_MarketcapUsd, yPlus10MarketcapUsd: Double?
    let liquidMarketcapUsd, volumeTurnoverLast24_HoursPercent, realizedMarketcapUsd, outstandingMarketcapUsd: Double?

    enum CodingKeys: String, CodingKey {
        case rank
        case marketcapDominancePercent = "marketcap_dominance_percent"
        case currentMarketcapUsd = "current_marketcap_usd"
        case y2050_MarketcapUsd = "y_2050_marketcap_usd"
        case yPlus10MarketcapUsd = "y_plus10_marketcap_usd"
        case liquidMarketcapUsd = "liquid_marketcap_usd"
        case volumeTurnoverLast24_HoursPercent = "volume_turnover_last_24_hours_percent"
        case realizedMarketcapUsd = "realized_marketcap_usd"
        case outstandingMarketcapUsd = "outstanding_marketcap_usd"
    }
}

// MARK: - Status
struct Status: Decodable {
    let elapsed: Int?
    let timestamp: String?
}

extension CoinModel: Comparable {
    static func < (lhs: CoinModel, rhs: CoinModel) -> Bool {
        lhs.data?.marketData.percentChangeUsdLast24_Hours ?? 0 < rhs.data?.marketData.percentChangeUsdLast24_Hours ?? 0
    }
    
    static func == (lhs: CoinModel, rhs: CoinModel) -> Bool {
        lhs.data?.marketData.percentChangeUsdLast24_Hours == rhs.data?.marketData.percentChangeUsdLast24_Hours
    }
}
