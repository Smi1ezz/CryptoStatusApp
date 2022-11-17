//
//  MainRouter.swift
//  CryptoStatusApp
//
//  Created by admin on 15.11.2022.
//

import Foundation
import UIKit

protocol MainRouterProtocol {
    func showRootScreen()
}

final class MainRouter: MainRouterProtocol {
    func showRootScreen() {
        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            delegate.appRouter?.showRootScreen()
        }
    }
}
