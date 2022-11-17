//
//  Errors.swift
//  CryptoStatusApp
//
//  Created by admin on 16.11.2022.
//

import Foundation

enum ErrorLogin: String, Error {
    case wrongInput
    case emptyInput
    case correctUserNotAvailable
}

enum ErrorNetwork: String, Error {
    case wrongFormatJSON
    case wrongURL
    case wrongRequest
    case wrongResponse
    case connectingProblem
    case dataNotFound
}

enum AppError: String, Error {
    case wrongMainTableViewCell
    case wrongMainTableViewHeader
    case emptyStorage
    case coinsToFetchAreNotAvailable
}
