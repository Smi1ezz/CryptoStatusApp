//
//  LoginPresenter.swift
//  CryptoStatusApp
//
//  Created by admin on 15.11.2022.
//

import Foundation
import UIKit

protocol LogInAblePresenter {
    func tryToLogIn(name: String, password: String) throws
}

protocol LoginPresenterProtocol: PresenterProtocol, LogInAblePresenter {

}

final class LoginPresenter: LoginPresenterProtocol {
    private let loginRouter: LoginRouterProtocol
    private let inputChecker: CheckProtocol
    private var userModel: UserModelProtocol?

    weak var presentedViewController: LoginViewControllerProtocol?

    init(router: LoginRouterProtocol, checker: CheckProtocol, user: UserModelProtocol) {
        self.loginRouter = router
        self.inputChecker = checker
        self.userModel = user
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
}
