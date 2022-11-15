//
//  UserModel.swift
//  CryptoStatusApp
//
//  Created by admin on 15.11.2022.
//

import Foundation

protocol UserModelProtocol {
    var name: String {get set}
    var password: String {get set}
}

struct UserModel: UserModelProtocol {
    var name: String
    var password: String

    init(name: String = "Login", password: String = "Pass") {
        self.name = name
        self.password = password
    }
}
