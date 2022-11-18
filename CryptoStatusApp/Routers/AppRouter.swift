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
    private var navigationVC: UINavigationController?

    func showRootScreen() {
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoginPassed.rawValue) {
            let viewController = GlobalBuilder.shared.buildMainVC()
            let navigationVC = UINavigationController(rootViewController: viewController)
            self.navigationVC = navigationVC
        } else {
            let loginVC = GlobalBuilder.shared.buildLoginVC()
            let navigationVC = UINavigationController(rootViewController: loginVC)
            self.navigationVC = navigationVC
        }

        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            delegate.window?.rootViewController = navigationVC
        }
    }
}
