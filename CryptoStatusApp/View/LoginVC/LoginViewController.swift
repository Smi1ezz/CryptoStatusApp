//
//  LoginViewController.swift
//  CryptoStatusApp
//
//  Created by admin on 04.11.2022.
//

import UIKit
import SnapKit

protocol LoginViewControllerDelegate: AnyObject {

}

class LoginViewController: UIViewController {

    private let scrollView = UIScrollView()

    private let containerView = UIView()

    private let label: UILabel = {
       let label = UILabel()
        label.text = "Add login and password"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    private let entranceView: UIView = {
        let entranceStackView = UIView()
        entranceStackView.backgroundColor = .systemGray5
        entranceStackView.makeBorder(borderColor: .darkGray, borderWidth: 0.5, cornerRadius: 10)
        entranceStackView.makeShadow(color: .black, opacity: 0.5, offSet: .zero, radius: 3)
        return entranceStackView
    }()

    private let loginTextField: UITextField = {
       let loginTextField = TextFieldWithPadding()
        loginTextField.placeholder = "Login"
        loginTextField.backgroundColor = .white
        loginTextField.clearButtonMode = .whileEditing
        loginTextField.makeBorder(borderColor: .darkGray, borderWidth: 0.5, cornerRadius: 10)
        return loginTextField
    }()

    private let passTextField: UITextField = {
       let passTextField = TextFieldWithPadding()
        passTextField.placeholder = "Password"
        passTextField.isSecureTextEntry = true
        passTextField.backgroundColor = .white
        passTextField.clearButtonMode = .whileEditing
        passTextField.makeBorder(borderColor: .darkGray, borderWidth: 0.5, cornerRadius: 10)
        return passTextField
    }()

    private let checkPassAndLogButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.makeShadow(color: .black, opacity: 0.5, offSet: .zero, radius: 3)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubViews()
        checkPassAndLogButton.addTarget(self, action: #selector(buttonTaped), for: .touchUpInside)
        hideKeyboard()

    }

    private func setupSubViews() {
        [loginTextField, passTextField, checkPassAndLogButton].forEach { entranceView.addSubview($0) }
        [label, entranceView].forEach { containerView.addSubview($0) }
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
        [loginTextField, passTextField].forEach { $0.delegate = self }
        setupConstraints()
    }

    private func setupConstraints() {

        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.top.bottom.width.height.equalToSuperview()
        }

        label.snp.makeConstraints { make in
            make.bottom.equalTo(entranceView.snp.top).offset(-15)
            make.centerX.equalToSuperview()
        }

        entranceView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(150)
        }

        loginTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(30)

        }

        passTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(10)
            make.leading.equalTo(entranceView.snp.leading).offset(20)
            make.trailing.equalTo(entranceView.snp.trailing).offset(-20)
            make.height.equalTo(30)

        }

        checkPassAndLogButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.trailing.equalTo(entranceView.snp.trailing).offset(-20)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }

    }

    @objc
    private func buttonTaped() {
        print("tap")
        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLoginPassed.rawValue)
            delegate.appRouter?.showRootScreen()
        }
    }
}

// MARK: extension for UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}