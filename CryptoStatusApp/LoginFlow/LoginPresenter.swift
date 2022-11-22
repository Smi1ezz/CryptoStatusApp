//
//  LoginPresenter.swift
//  CryptoStatusApp
//
//  Created by admin on 15.11.2022.
//

import Foundation
import UIKit

protocol LoginPresenterProtocol: PresenterProtocol, RoutablePresenter, LogInAblePresenter {
    func addCurrentUser(user: UserModelProtocol)
}

final class LoginPresenter: LoginPresenterProtocol {
    private let loginRouter: LoginRouterProtocol
    private let inputChecker: CheckerProtocol
    private var userModel: UserModelProtocol?

    weak var presentedViewController: LoginViewControllerProtocol? {
        didSet {
            setupRouterNavigation()
        }
    }

    init(router: LoginRouterProtocol, checker: CheckerProtocol, user: UserModelProtocol? = nil) {
        self.loginRouter = router
        self.inputChecker = checker
        self.userModel = user
    }

    func setupRouterNavigation() {
        guard let naviVC = (presentedViewController as? UIViewController)?.navigationController else {
            return
        }
        self.loginRouter.setNavigationController(naviVC)
    }

    func setDelegateVC(_ delegate: UIViewController) {
        self.presentedViewController = delegate as? LoginViewControllerProtocol
    }

    func tryToLogIn(name: String, password: String) throws {
        guard let correctUser = self.userModel else {
            throw ErrorLogin.correctUserNotAvailable
        }
        inputChecker.setCorrect(user: correctUser)

        let inputUser = UserModel(name: name, password: password)

        if inputChecker.check(user: inputUser) {
            presentedViewController?.successEntrance()
            UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLoginPassed.rawValue)

            let successAnimationDuration = 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + successAnimationDuration) { [weak self] in
                self?.loginRouter.showRootScreen()
            }
        } else {
            presentedViewController?.failEntranse()
            throw ErrorLogin.wrongInput
        }
    }

    func addCurrentUser(user: UserModelProtocol) {
        self.userModel = user
    }
}
