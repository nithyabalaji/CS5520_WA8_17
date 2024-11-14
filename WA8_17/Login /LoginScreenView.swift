//
//  LoginScreenView.swift
//  WA8_17
//
//  Created by Nithya Balaji on 11/7/24.
//

import UIKit

class LoginScreenView: UIView {

    var contentWrapper:UIScrollView!
    var loginLabel: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var errorLabel: UILabel!
    var noAccountLabel: UILabel!
    var registerButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupLoginLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupErrorLabel()
        setupNoAccountLabel()
        setupRegisterButton()
        
        initConstraints()
    
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupLoginLabel() {
        loginLabel = UILabel()
        loginLabel.text = "Login"
        loginLabel.font = UIFont.boldSystemFont(ofSize: 32)
        loginLabel.textColor = .systemBlue
        addSubviewToContainer(subview: loginLabel)
    }
    
    func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        emailTextField.borderStyle = .roundedRect
        emailTextField.font = emailTextField.font?.withSize(16)
        addSubviewToContainer(subview: emailTextField)
    }
    
    func setupPasswordTextField() {
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.font = passwordTextField.font?.withSize(16)
        addSubviewToContainer(subview: passwordTextField)
    }
    
    func setupLoginButton() {
        loginButton = UIButton(type: .roundedRect)
        loginButton.setTitle("Login", for: .normal)
        setupButton(button: loginButton)
    }
    
    func setupErrorLabel() {
        errorLabel = UILabel()
        errorLabel.font = UIFont.systemFont(ofSize: 16)
        errorLabel.textColor = .systemRed
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        addSubviewToContainer(subview: errorLabel)
    }
    
    func setupNoAccountLabel() {
        noAccountLabel = UILabel()
        noAccountLabel.text = "Don't have an account yet? Register here."
        noAccountLabel.font = UIFont.systemFont(ofSize: 14)
        noAccountLabel.textColor = .systemBlue
        addSubviewToContainer(subview: noAccountLabel)
    }
    
    func setupRegisterButton() {
        registerButton = UIButton(type: .roundedRect)
        registerButton.setTitle("Register", for: .normal)
        setupButton(button: registerButton)
    }
    
    func setupButton(button: UIButton) {
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        addSubviewToContainer(subview: button)
    }
    
    func addSubviewToContainer(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.contentWrapper.addSubview(subview)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            loginLabel.topAnchor.constraint(equalTo: self.contentWrapper.topAnchor, constant: 48),
            loginLabel.centerXAnchor.constraint(equalTo: self.contentWrapper.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 16),
            emailTextField.centerXAnchor.constraint(equalTo: self.contentWrapper.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.centerXAnchor.constraint(equalTo: self.contentWrapper.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            loginButton.centerXAnchor.constraint(equalTo: self.contentWrapper.centerXAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12),
            errorLabel.centerXAnchor.constraint(equalTo: self.contentWrapper.centerXAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: self.contentWrapper.trailingAnchor, constant: -16),
            
            noAccountLabel.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 48),
            noAccountLabel.centerXAnchor.constraint(equalTo: self.contentWrapper.centerXAnchor),
            
            registerButton.topAnchor.constraint(equalTo: noAccountLabel.bottomAnchor, constant: 12),
            registerButton.centerXAnchor.constraint(equalTo: self.contentWrapper.centerXAnchor),
            registerButton.bottomAnchor.constraint(equalTo: self.contentWrapper.bottomAnchor),
        ])
        textFieldConstraints(emailTextField)
        textFieldConstraints(passwordTextField)
    }
    
    func textFieldConstraints(_ textField: UITextField) {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 48),
            textField.trailingAnchor.constraint(equalTo: self.contentWrapper.trailingAnchor, constant: -48),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
