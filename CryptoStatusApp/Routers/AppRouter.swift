//
//  AppRouter.swift
//  CryptoStatusApp
//
//  Created by admin on 04.11.2022.
//

import UIKit

protocol AppRouterType: AnyObject {
    func showRootScreen()
}

final class AppRouter: AppRouterType {
    private(set) var window: UIWindow
    private var navigationVC: UINavigationController?

    init(window: UIWindow) {
        self.window = window
    }

    func showRootScreen() {
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoginPassed.rawValue) {
            // вход без логина и пароля

//            let viewController = GlobalBuilder.shared.buildAnotherVC()

//            let navigationVC = UINavigationController(rootViewController: viewController)
//            self.navigationVC = navigationVC
        } else {
//            let loginVC = LoginViewController(presenter: LoginPresenter())
            let loginVC = GlobalBuilder.shared.buildLoginVC()
            let navigationVC = UINavigationController(rootViewController: loginVC)
            self.navigationVC = navigationVC
        }

        window.rootViewController = navigationVC
        window.makeKeyAndVisible()

        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                delegate.window = window
        }
    }
}
