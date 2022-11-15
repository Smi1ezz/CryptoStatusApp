//
//  GlobalBuilder.swift
//  CryptoStatusApp
//
//  Created by admin on 15.11.2022.
//
import Foundation
import UIKit

final class GlobalBuilder {
    static let shared = GlobalBuilder()

    private init() {

    }

    func buildLoginVC() -> UIViewController {
        let loginRouter = LoginRouter()
        let userModel = UserModel(name: "Login", password: "Pass")
        let inputChecker = LogInChecker()
        let loginPresenter = LoginPresenter(router: loginRouter, checker: inputChecker, user: userModel)
        return LoginViewController(presenter: loginPresenter)
    }

    func buildMainVC() -> UIViewController {
        return MainViewController()
    }
}
