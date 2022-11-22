//
//  GlobalRouterProtocols.swift
//  CryptoStatusApp
//
//  Created by admin on 22.11.2022.
//

import Foundation
import UIKit

protocol AppRouterProtocol: AnyObject {
    func showRootScreen()
}

protocol RouterProtocol {
    func setNavigationController(_ naviVC: UINavigationController)
}
