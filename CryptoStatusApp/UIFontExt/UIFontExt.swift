//
//  UIFontExt.swift
//  CryptoStatusApp
//
//  Created by admin on 17.11.2022.
//

import UIKit

extension UIFont {
    static func smallAppFont() -> UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    static func mediumAppFont() -> UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    static func bigAppFont() -> UIFont {
        return UIFont.systemFont(ofSize: 24, weight: .bold)
    }
}
