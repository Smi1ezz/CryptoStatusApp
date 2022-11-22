//
//  CryptoCoinRespModel.swift
//  CryptoStatusApp
//
//  Created by admin on 04.11.2022.
//

import Foundation

protocol DetailableCoin {
    var status: Status? {get}
    var data: DataStruct? {get}
}

// MARK: - FullDetailsResponse
struct CryptoCoinRespModel: Codable, DetailableCoin {
    var status: Status?
    var data: DataStruct?
}

// MARK: - DataStruct
struct DataStruct: Codable {
    let id: String?
    let serialID: Int?
    let symbol: String?
    let name: String?
    let marketData: MarketData?
    let developerActivity: DeveloperActivity?

    enum CodingKeys: String, CodingKey {
        case id
        case serialID = "serial_id"
        case symbol, name
        case marketData = "market_data"
        case developerActivity = "developer_activity"
    }
}

// MARK: - DeveloperActivity
 struct DeveloperActivity: Codable {
    let stars, watchers: Int?

    enum CodingKeys: String, CodingKey {
        case stars, watchers
    }
 }

// MARK: - MarketData
 struct MarketData: Codable {
    let priceUsd, priceBtc, priceEth: Double?
    let percentChangeUsdLast1Hour, percentChangeBtcLast1Hour, percentChangeEthLast1Hour: Double?
    let percentChangeUsdLast24Hours, percentChangeBtcLast24Hours, percentChangeEthLast24Hours: Double?

    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case priceBtc = "price_btc"
        case priceEth = "price_eth"
        case percentChangeUsdLast1Hour = "percent_change_usd_last_1_hour"
        case percentChangeBtcLast1Hour = "percent_change_btc_last_1_hour"
        case percentChangeEthLast1Hour = "percent_change_eth_last_1_hour"
        case percentChangeUsdLast24Hours = "percent_change_usd_last_24_hours"
        case percentChangeBtcLast24Hours = "percent_change_btc_last_24_hours"
        case percentChangeEthLast24Hours = "percent_change_eth_last_24_hours"
    }
 }

// MARK: - Status
struct Status: Codable {
    let elapsed: Int?
    let timestamp: String?
}
