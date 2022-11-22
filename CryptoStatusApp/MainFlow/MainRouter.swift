//
//  MainRouter.swift
//  CryptoStatusApp
//
//  Created by admin on 15.11.2022.
//

import Foundation
import UIKit

protocol MainRouterProtocol: AppRouterProtocol, RouterProtocol {
    func showDetailsVC(about data: DetailableCoin)
}

final class MainRouter: MainRouterProtocol {
    weak private var navigationVC: UINavigationController?

    func setNavigationController(_ naviVC: UINavigationController) {
        self.navigationVC = naviVC
    }

    func showRootScreen() {
        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            delegate.appRouter?.showRootScreen()
        }
    }

    func showDetailsVC(about data: DetailableCoin) {
        let detailsVC = GlobalBuilder.shared.buildDetailsVC(about: data)
        navigationVC?.pushViewController(detailsVC, animated: true)
    }
}
