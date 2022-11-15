//
//  UIViewAnimation.swift
//  CryptoStatusApp
//
//  Created by admin on 14.11.2022.
//

import UIKit

extension UIView {
    func shakeIt() {
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, animations: {

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
                self.backgroundColor = .red
            })

            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25, animations: {
                self.backgroundColor = .systemGray6
            })
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
                self.center.x += 5

            })
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.5, animations: {
                self.center.x -= 10
            })
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                self.center.x += 5
            })

        })
    }

}
