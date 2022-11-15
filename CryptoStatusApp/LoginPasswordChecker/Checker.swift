//
//  Checker.swift
//  CryptoStatusApp
//
//  Created by admin on 14.11.2022.
//

import Foundation

protocol CheckProtocol {
    func setCorrect(user: UserModelProtocol)
    func check(user: UserModelProtocol) -> Bool
}

protocol CheckerDelegate: AnyObject {
    func failEntranse()
    func successEntrance()
}

class LogInChecker: CheckProtocol {
    weak var delegate: CheckerDelegate?

    private var correctUser: UserModelProtocol?

    init(correctUser: UserModelProtocol? = nil) {
        self.correctUser = correctUser
    }

    func setCorrect(user: UserModelProtocol) {
        self.correctUser = user
    }

    func check(user: UserModelProtocol) -> Bool {
        if user.name == self.correctUser?.name && user.password == self.correctUser?.password {
            delegate?.successEntrance()
            return true
        } else {
            delegate?.failEntranse()
            return false
        }
    }
}
