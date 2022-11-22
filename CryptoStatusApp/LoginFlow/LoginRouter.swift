//
//  LoginRouter.swift
//  CryptoStatusApp
//
//  Created by admin on 15.11.2022.
//

import Foundation
import UIKit

protocol LoginRouterProtocol: AppRouterProtocol {

}

final class LoginRouter: LoginRouterProtocol {
    func showRootScreen() {
        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            delegate.appRouter?.showRootScreen()
        }
    }
}
