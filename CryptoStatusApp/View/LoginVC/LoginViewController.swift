//
//  LoginViewController.swift
//  CryptoStatusApp
//
//  Created by admin on 04.11.2022.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {

}

final class LoginViewController: UIViewController {

    private let loginView = LoginScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubViews()
        hideKeyboard()
    }

    private func setupSubViews() {
        view.addSubview(loginView)
        loginView.setupSubViews()
        loginView.setupTextField(delegate: self)
        loginView.setupLoginButtonAction(target: self, action: #selector(buttonTaped), for: .touchUpInside)
    }

    @objc
    private func buttonTaped() {
        print("tap")
        loginView.wrongEntranse()
    }
}

// MARK: ext for UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: ext for CheckerDelegate
extension LoginViewController: CheckerDelegate {
    func wrongLogin() {
        print("wrongLogin")
    }

    func wrongPassword() {
        print("wrongPassword")
    }

    func successEntrance() {
        print("successEntrance")
        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLoginPassed.rawValue)
            delegate.appRouter?.showRootScreen()
        }
    }
}
