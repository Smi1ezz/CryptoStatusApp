//
//  AppRouter.swift
//  CryptoStatusApp
//
//  Created by admin on 04.11.2022.
//

import UIKit

final class AppRouter: AppRouterProtocol {
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

        setupNavigationAppearance()

        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            delegate.window?.rootViewController = navigationVC
        }
    }

    private func setupNavigationAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .appColor(name: .loginViewGreen)
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appColor(name: .appGreen)]
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UIBarButtonItem.appearance().tintColor = UIColor.appColor(name: .appGreen)
    }
}
