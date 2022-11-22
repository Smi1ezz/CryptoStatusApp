//
//  LoginRouter.swift
//  CryptoStatusApp
//
//  Created by admin on 15.11.2022.
//

import Foundation
import UIKit

protocol LoginRouterProtocol: AppRouterProtocol, RouterProtocol {

}

final class LoginRouter: LoginRouterProtocol {
    weak private var navigationVC: UINavigationController?

    func setNavigationController(_ naviVC: UINavigationController) {
        self.navigationVC = naviVC
    }

    func showRootScreen() {
        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            delegate.appRouter?.showRootScreen()
        }
    }
}
