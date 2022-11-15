//
//  LoginViewController.swift
//  CryptoStatusApp
//
//  Created by admin on 04.11.2022.
//

import UIKit

protocol LoginViewControllerDelegate: CheckerDelegate {

}

final class LoginViewController: UIViewController {

    private var presenter: LoginPresenterProtocol

    private let loginView = LoginScrollView()

    private var inputName: String?
    private var inputPassword: String?

    init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubViews()
        presenter.setDelegateVC(self)
        activateHidableKeyboard()
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
        guard let inputName = inputName, let inputPassword = inputPassword else {
            loginView.wrongEntranse()
            return
        }

        presenter.tryToLogIn(name: inputName, password: inputPassword)
    }
}

// MARK: ext for LoginViewControllerDelegate
extension LoginViewController: LoginViewControllerDelegate {

}

// MARK: ext for UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            self.inputName = textField.text
        } else if textField.tag == 2 {
            self.inputPassword = textField.text
        }
        textField.resignFirstResponder()

    }
}

// MARK: ext for CheckerDelegate
extension LoginViewController: CheckerDelegate {
    func failEntranse() {
        print("wrongLogin")
        loginView.wrongEntranse()
    }

    func successEntrance() {
        print("successEntrance")
        loginView.successEntranse()
    }
}
