//
//  UIViewShadowExt.swift
//  CryptoStatusApp
//
//  Created by admin on 14.11.2022.
//

import UIKit

extension UIView {
    func makeShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
}
