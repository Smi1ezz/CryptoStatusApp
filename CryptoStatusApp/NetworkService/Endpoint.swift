//
//  Endpoint.swift
//  CryptoStatusApp
//
//  Created by admin on 04.11.2022.
//
//https://data.messari.io/api/v1/assets/trx/metrics

import Foundation

enum CoinNames: String {
    case btc, eth, tron, luna, polkadot, dogecoin, tether, stellar, cardano, xrp
}

enum HTTPMethods: String {
    case GET, SET, POST, DELETE
}

protocol EndpointProtocol {
    var headers: [String: String] {get}
    var scheme: String {get}
    var host: String {get}
    var path: String {get}
    var parameters: [URLQueryItem] {get}
    var strURL: String? {get}
    func makeURLRequest(method: HTTPMethods) -> URLRequest?
}

enum Endpoint: EndpointProtocol {
    case getCoin(name: CoinNames)

    var headers: [String: String] {
        switch self {
        case .getCoin:
            return [:]
        }
    }

    var scheme: String {
        return "https"
    }

    var host: String {
        return "data.messari.io"
    }

    var path: String {
        switch self {
        case .getCoin(let name):
            return "/api/v1/assets/\(name.rawValue)/metrics"
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        case .getCoin:
            return []
        }
    }

    var strURL: String? {
        return makeStringURL()
    }

    func makeURLRequest(method: HTTPMethods) -> URLRequest? {
        let urlStr = makeStringURL()
        guard let urlStr = urlStr, let url = URL(string: urlStr) else {
            print("func makeURLRequest error, wrong url")
            return nil
        }

        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        request.httpMethod = method.rawValue

        return request
    }

    private func makeStringURL() -> String? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = parameters

        return urlComponents.string
    }
}
