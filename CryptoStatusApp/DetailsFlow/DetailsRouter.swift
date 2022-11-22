//
//  DetailsRouter.swift
//  CryptoStatusApp
//
//  Created by admin on 18.11.2022.
//

import Foundation
import UIKit

protocol DetailsRouterProtocol: AppRouterProtocol {

}

final class DetailsRouter: DetailsRouterProtocol {
    func showRootScreen() {
        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            delegate.appRouter?.showRootScreen()
        }
    }
}
