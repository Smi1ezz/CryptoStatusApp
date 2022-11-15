//
//  Checker.swift
//  CryptoStatusApp
//
//  Created by admin on 14.11.2022.
//

import Foundation

protocol CheckProtocol {
    func check(login: String, password: String) -> Bool
}

protocol CheckerDelegate: AnyObject {
    func wrongLogin()
    func wrongPassword()
    func successEntrance()
}

class CheckerModel: CheckProtocol {

    static let instance = CheckerModel(login: "Login", password: "Pass")

    weak var delegate: CheckerDelegate?

    private let login: String
    private let pswd: String

    private init(login: String, password: String) {
        self.login = login
        self.pswd = password
    }

    func check(login: String, password: String) -> Bool {
        if login == self.login && password == self.pswd {
            delegate?.successEntrance()
            return true
        } else if login != self.login {
            delegate?.wrongLogin()
            return false
        } else if password != self.pswd {
            delegate?.wrongPassword()
            return false
        } else {
            return false
        }
    }
}
