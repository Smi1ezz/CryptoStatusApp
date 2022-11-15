//
//  LoginPresenter.swift
//  CryptoStatusApp
//
//  Created by admin on 15.11.2022.
//

import Foundation
import UIKit

protocol LoginPresenterProtocol {
    func setDelegateVC(_ delegate: LoginViewControllerDelegate)
    func tryToLogIn(name: String, password: String)
}

final class LoginPresenter: LoginPresenterProtocol {
    private let loginRouter: LoginRouterProtocol
    private let inputChecker: CheckProtocol
    private var userModel: UserModelProtocol?

    weak var presentedViewController: LoginViewControllerDelegate?

    init(router: LoginRouterProtocol, checker: CheckProtocol, user: UserModelProtocol) {
        self.loginRouter = router
        self.inputChecker = checker
        self.userModel = user
    }

    func setDelegateVC(_ delegate: LoginViewControllerDelegate) {
        self.presentedViewController = delegate
    }

    func tryToLogIn(name: String, password: String) {
        guard let correctUser = self.userModel else {
            return
        }
        inputChecker.setCorrect(user: correctUser)

        let inputUser = UserModel(name: name, password: password)

        if inputChecker.check(user: inputUser) {
            presentedViewController?.successEntrance()
            let successAnimationDuration = 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + successAnimationDuration) {
                if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLoginPassed.rawValue)
                    delegate.appRouter?.showRootScreen()
                }
            }
        } else {
            presentedViewController?.failEntranse()
        }
    }
}
