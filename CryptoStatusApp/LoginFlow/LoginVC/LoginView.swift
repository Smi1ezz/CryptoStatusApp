//
//  LoginView.swift
//  CryptoStatusApp
//
//  Created by admin on 14.11.2022.
//

import UIKit
import SnapKit

final class LoginScrollView: UIScrollView {
    // MARK: Properties

    private let containerView = UIView()

    private let label: UILabel = {
       let label = UILabel()
        label.text = "Add login and password"
        label.textAlignment = .center
        label.textColor = UIColor.appColor(name: .appGreen)
        label.font = UIFont.bigAppFont()
        return label
    }()

    private let entranceView: UIView = {
        let entranceStackView = UIView()
        entranceStackView.backgroundColor = UIColor.appColor(name: .loginViewGreen)
        entranceStackView.makeBorder(borderColor: .darkGray, borderWidth: 0.5, cornerRadius: 10)
        entranceStackView.makeShadow(color: .black, opacity: 0.5, offSet: .zero, radius: 3)
        return entranceStackView
    }()

    private let loginTextField: UITextField = {
       let loginTextField = TextFieldWithPadding()
        loginTextField.tag = 1
        loginTextField.placeholder = "Login"
        loginTextField.backgroundColor = UIColor.appColor(name: .loginViewGreen)
        loginTextField.clearButtonMode = .whileEditing
        loginTextField.makeBorder(borderColor: .darkGray, borderWidth: 0.5, cornerRadius: 10)
        return loginTextField
    }()

    private let passTextField: UITextField = {
       let passTextField = TextFieldWithPadding()
        passTextField.tag = 2
        passTextField.placeholder = "Password"
        passTextField.isSecureTextEntry = true
        passTextField.backgroundColor = UIColor.appColor(name: .loginViewGreen)
        passTextField.clearButtonMode = .whileEditing
        passTextField.makeBorder(borderColor: .darkGray, borderWidth: 0.5, cornerRadius: 10)
        return passTextField
    }()

    private let checkPassAndLogButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.appColor(name: .appGreen)
        button.tintColor = UIColor.appColor(name: .backgroundBlack)
        button.setTitle("LogIn", for: .normal)
        button.layer.cornerRadius = 10
        button.makeShadow(color: .black, opacity: 0.5, offSet: .zero, radius: 3)
        return button
    }()

    // MARK: Methods

    func setupSubViews() {
        [loginTextField, passTextField, checkPassAndLogButton].forEach { entranceView.addSubview($0) }
        [label, entranceView].forEach { containerView.addSubview($0) }
        self.addSubview(containerView)
        setupConstraints()
    }

    func setupTextField(delegate: UITextFieldDelegate) {
        [loginTextField, passTextField].forEach { $0.delegate = delegate }
    }

    func setupLoginButtonAction(target: Any?, action: Selector, for event: UIControl.Event) {
        checkPassAndLogButton.addTarget(target, action: action, for: event)
    }

    func wrongEntranse() {
        entranceView.shakeIt()
    }

    func successEntranse() {
        checkPassAndLogButton.blinkIt(color: .green)
    }

    private func setupConstraints() {

        self.snp.makeConstraints { make in
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
}

extension LoginScrollView: ErrorShowableView {
    func showAlert(error: Error) {

    }

    func showError(_ error: Error) {
        let errorLabel: UILabel = {
            let errorLabel = UILabel()
            errorLabel.text = (error as? ErrorLogin)?.rawValue
            errorLabel.textColor = .red
            errorLabel.textAlignment = .center
            errorLabel.font = UIFont.mediumAppFont()
            return errorLabel
        }()
        containerView.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(entranceView.snp.bottom).offset(20)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            errorLabel.removeFromSuperview()
        }
    }
}
