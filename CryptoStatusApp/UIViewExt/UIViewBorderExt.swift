//
//  UIViewBorderExt.swift
//  CryptoStatusApp
//
//  Created by admin on 14.11.2022.
//

import UIKit

extension UIView {
    func makeBorder(borderColor: UIColor = UIColor.black, borderWidth: CGFloat = 0.5, cornerRadius: CGFloat = 0) {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = 10
    }
}
