//
//  DetailsRouter.swift
//  CryptoStatusApp
//
//  Created by admin on 18.11.2022.
//

import Foundation
import UIKit

protocol DetailsRouterProtocol: AppRouterProtocol, RouterProtocol {

}

final class DetailsRouter: DetailsRouterProtocol {
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
