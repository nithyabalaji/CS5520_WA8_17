//
//  RightBarButtonManager.swift
//  WA8_17
//
//  Created by Nithya Balaji on 11/7/24.
//

import Foundation
import UIKit
import FirebaseAuth

extension ViewController{
    func setupRightBarButton(isLoggedin: Bool){
        if isLoggedin{
            //MARK: user is logged in...
            let barText = UIBarButtonItem(
                title: "Logout",
                style: .plain,
                target: self,
                action: #selector(onLogOutBarButtonTapped)
            )
            
            navigationItem.rightBarButtonItem = barText
            
        }else{
            //MARK: not logged in...
            let barText = UIBarButtonItem(
                title: "Sign in",
                style: .plain,
                target: self,
                action: #selector(onSignInBarButtonTapped)
            )
            
            navigationItem.rightBarButtonItem = barText
        }
    }
    
    @objc func onSignInBarButtonTapped(){
        let loginController = LoginScreenViewController()
        navigationController?.pushViewController(loginController, animated: true)
    }
/*
    func signInToFirebase(email: String, password: String){
        //MARK: can you display progress indicator here?
        self.showActivityIndicator()
        //MARK: authenticating the user...
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil{
                //MARK: user authenticated...
                //MARK: can you hide the progress indicator here?
                self.hideActivityIndicator()
            }else{
                //MARK: alert that no user found or password wrong...
            }
        })
    }
 */

    
    @objc func onLogOutBarButtonTapped(){
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?",
            preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }
}
/*
 extension ViewController:ProgressSpinnerDelegate{
 func showActivityIndicator(){
 addChild(childProgressView)
 view.addSubview(childProgressView.view)
 childProgressView.didMove(toParent: self)
 }
 
 func hideActivityIndicator(){
 childProgressView.willMove(toParent: nil)
 childProgressView.view.removeFromSuperview()
 childProgressView.removeFromParent()
 }
 }
 */
