//
//  GlobalViewProtocols.swift
//  CryptoStatusApp
//
//  Created by admin on 22.11.2022.
//

import Foundation
import UIKit

protocol ErrorShowableView {
    func showError(_ error: Error)
    func showAlert(error: Error)
}

protocol SpinnerableView {
    var spinner: UIActivityIndicatorView {get}
    func startSpinner()
    func stopSpinner()
}
