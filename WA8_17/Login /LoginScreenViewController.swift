//
//  LoginScreenViewController.swift
//  WA8_17
//
//  Created by Nithya Balaji on 11/7/24.
//

import UIKit
import FirebaseAuth

class LoginScreenViewController: UIViewController {
    
    let loginScreen = LoginScreenView()
    
    override func loadView() {
        view = loginScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        loginScreen.loginButton.addTarget(self, action: #selector(onButtonLoginTapped), for: .touchUpInside)
        loginScreen.registerButton.addTarget(self, action: #selector(onButtonRegisterTapped), for: .touchUpInside)
    }
    
    @objc func onButtonLoginTapped(){
        let emailInput = loginScreen.emailTextField.text
        let passwordInput = loginScreen.passwordTextField.text
        if let email = emailInput, let password = passwordInput {
            if !email.isEmpty, !password.isEmpty {
                loginScreen.errorLabel.text = ""
                login(email: email, password: password)
            } else {
                loginScreen.errorLabel.text = "Email and password should be filled out before logging in."
            }
        }
    }
    
    func login(email: String, password: String){
        //self.showActivityIndicator()
        //MARK: authenticating the user...
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil{
                //MARK: user authenticated...
                //self.hideActivityIndicator()
                self.navigationController?.popViewController(animated: true)
            }else{
                //MARK: alert that no user found or password wrong...
                print(error)
                if let errorMsg = error?.localizedDescription {
                    self.loginScreen.errorLabel.text = "Incorrect email or password."
                }
            }
        })
    }
    
    @objc func onButtonRegisterTapped(){
        //let registerController = RegisterScreenViewController()
        //navigationController?.pushViewController(registerController, animated: true)
    }
    
    
    
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
}

