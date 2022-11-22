//
//  AppColors.swift
//  CryptoStatusApp
//
//  Created by admin on 21.11.2022.
//

import Foundation
import UIKit

enum AppColors {
    case backgroundBlack, cellBackgroundGreen, appGreen, loginViewGreen
}

extension UIColor {
    static func appColor(name: AppColors) -> UIColor {
        switch name {
        case .backgroundBlack:
            return UIColor(named: "backgroundBlack") ?? .black
        case .cellBackgroundGreen:
            return UIColor(named: "cellBackgroundGreen") ?? .systemGray5
        case .appGreen:
            return UIColor(named: "appGreen") ?? .green
        case .loginViewGreen:
            return UIColor(named: "loginViewGreen") ?? .green
        }
    }
}
