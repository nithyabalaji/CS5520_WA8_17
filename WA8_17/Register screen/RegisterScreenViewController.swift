
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
        
        // Check for empty fields
        if let name = name, let email = email, let password = password, let repeatPassword = repeatPassword {
            if name.isEmpty || email.isEmpty || password.isEmpty || repeatPassword.isEmpty {
                registerScreen.errorLabel.text = "All fields are required."
                return
            }
            
            // Check if passwords match
            if password != repeatPassword {
                registerScreen.errorLabel.text = "Passwords do not match."
                return
            }
            
            // Clear error label if validation passes
            registerScreen.errorLabel.text = ""
            
            // Register the user with Firebase
            registerUser(email: email, password: password)
        }
    }
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.registerScreen.errorLabel.text = error.localizedDescription
            } else if let authResult = authResult {
                // Registration successful, save user details to Firestore
                let userName = self.registerScreen.nameTextField.text ?? "Anonymous"
                
                // Set user data in Firestore
                let userData: [String: Any] = [
                    "name": userName,
                    "email": email,
                ]
                
                Firestore.firestore().collection("users").document(email).setData(userData) { error in
                    if let error = error {
                        self.registerScreen.errorLabel.text = "Error saving user data: \(error.localizedDescription)"
                    } else {
                        // Successfully saved user data, navigate to main screen
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }

}
