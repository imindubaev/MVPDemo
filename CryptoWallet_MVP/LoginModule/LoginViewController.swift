//
//  LoginViewController.swift
//  CryptoWallet_MVP
//
//  Created by Ilnur Mindubayev on 21.11.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    var presenter: LoginViewPresenterProtocol!
    
    private let loginScreenLabel = UILabel()
    private let loginLabel = UILabel()
    private let loginTextField = UITextField()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let isLoggedInLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    @objc private func loginButtonPressed() {
        presenter.loginButtonPressed(login: loginTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    func setupUI() {
        
        // loginScreenLabel setup
        view.addSubview(loginScreenLabel)
        loginScreenLabel.text = "Crypto Wallet"
        loginScreenLabel.textAlignment = .center
        loginScreenLabel.translatesAutoresizingMaskIntoConstraints = false
        loginScreenLabel.font = UIFont.systemFont(ofSize: 34.0)
        
        NSLayoutConstraint.activate([
            loginScreenLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            loginScreenLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginScreenLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // loginLabel setup
        view.addSubview(loginLabel)
        loginLabel.text = "Login"
        loginLabel.textColor = .lightGray
        loginLabel.textAlignment = .left
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: loginScreenLabel.bottomAnchor, constant: 30),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        // loginTextField setup
        view.addSubview(loginTextField)
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.borderStyle = .roundedRect
        loginTextField.clearButtonMode = .always
        loginTextField.returnKeyType = UIReturnKeyType.next
                
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 10),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // passwordLabel setup
        view.addSubview(passwordLabel)
        passwordLabel.text = "Password"
        passwordLabel.textColor = .lightGray
        passwordLabel.textAlignment = .left
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 10),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        // passwordTextField setup
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
//        passwordTextField.keyboardType = .numberPad
        passwordTextField.clearButtonMode = .always
        passwordTextField.returnKeyType = UIReturnKeyType.done
        // Доделать переход на другой текст филд, клавишу энтер
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // isLoggedInLabel setup
        view.addSubview(isLoggedInLabel)
        isLoggedInLabel.text = " "
        isLoggedInLabel.textAlignment = .center
        isLoggedInLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            isLoggedInLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            isLoggedInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            isLoggedInLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // loginButton setup
        view.addSubview(loginButton)
        loginButton.configuration = .filled()
        loginButton.configuration?.title = "Log in"
        loginButton.configuration?.baseBackgroundColor = .white
        loginButton.configuration?.baseBackgroundColor = .systemBlue
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: isLoggedInLabel.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120)
        ])
    }
}

extension LoginViewController: LoginViewProtocol {
    func loginFailed() {
        isLoggedInLabel.text = "Log in failed"
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            loginButtonPressed()
            textField.resignFirstResponder()
        }
        return true
    }
}
