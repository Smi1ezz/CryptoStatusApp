//
//  TextFieldWithPadding.swift
//  CryptoStatusApp
//
//  Created by admin on 14.11.2022.
//

import UIKit

final class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

    func makePadding(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        self.textPadding = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
