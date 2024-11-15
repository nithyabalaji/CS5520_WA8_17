
import UIKit
import FirebaseAuth
import FirebaseFirestore


class RegisterScreenViewController: UIViewController {
    
    let registerScreen = RegisterScreenView()
    
    override func loadView() {
        view = registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerScreen.registerButton.addTarget(self, action: #selector(onRegisterButtonTapped), for: .touchUpInside)
    }
    
    @objc func onRegisterButtonTapped() {
        let name = registerScreen.nameTextField.text
        let email = registerScreen.emailTextField.text
        let password = registerScreen.passwordTextField.text
        let repeatPassword = registerScreen.repeatPasswordTextField.text

        if let name = name, let email = email, let password = password, let repeatPassword = repeatPassword {
            if name.isEmpty || email.isEmpty || password.isEmpty || repeatPassword.isEmpty {
                registerScreen.errorLabel.text = "All fields are required."
                return
            }

            if password != repeatPassword {
                registerScreen.errorLabel.text = "Passwords do not match."
                return
            }

            registerScreen.errorLabel.text = ""

            // Start Activity Indicator
            registerScreen.activityIndicator.startAnimating()

            registerUser(email: email, password: password) { [weak self] userName, error in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.registerScreen.activityIndicator.stopAnimating() // Stop Activity Indicator
                    if let error = error {
                        self.registerScreen.errorLabel.text = error.localizedDescription
                    } else if let userName = userName {
                        if let navigationController = self.navigationController,
                           let mainViewController = navigationController.viewControllers.first as? ViewController {
                            mainViewController.userName = userName
                        }
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }

    func registerUser(email: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(nil, error)
                return
            }

            let userName = self.registerScreen.nameTextField.text ?? "Anonymous"
            let userData: [String: Any] = [
                "name": userName,
                "email": email,
            ]

            Firestore.firestore().collection("users").document(email).setData(userData) { error in
                if let error = error {
                    completion(nil, error)
                } else {
                    completion(userName, nil)
                }
            }
        }
    }



}
