//
//  GlobalBuilder.swift
//  CryptoStatusApp
//
//  Created by admin on 15.11.2022.
//

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
        let mainRouter = MainRouter()
        let networkManager = CryptoNetworkManager()
        let mainPresenter = MainPresenter(router: mainRouter, networkManager: networkManager, cryptoCoinsModel: nil)
        return MainViewController(presenter: mainPresenter)
    }
}
