//
//  MainRouter.swift
//  CryptoStatusApp
//
//  Created by admin on 15.11.2022.
//

import Foundation
import UIKit

protocol MainRouterProtocol: AppRouterProtocol {
    func showDetailsVC(about data: DetailableCoin)
}

final class MainRouter: MainRouterProtocol {
    func showRootScreen() {
        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            delegate.appRouter?.showRootScreen()
        }
    }

    func showDetailsVC(about data: DetailableCoin) {
        let detailsVC = GlobalBuilder.shared.buildDetailsVC(about: data)
        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            (delegate.window?.rootViewController as? UINavigationController)?.pushViewController(detailsVC, animated: true)
        }
    }
}
