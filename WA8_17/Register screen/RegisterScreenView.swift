import UIKit

class RegisterScreenView: UIView {

    var contentWrapper: UIScrollView!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var repeatPasswordTextField: UITextField!
    var registerButton: UIButton!
    var errorLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupRepeatPasswordTextField()
        setupRegisterButton()
        setupErrorLabel()
        
        initConstraints()
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupNameTextField() {
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        addSubviewToContainer(subview: nameTextField)
    }
    
    func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.borderStyle = .roundedRect
        addSubviewToContainer(subview: emailTextField)
    }
    
    func setupPasswordTextField() {
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        addSubviewToContainer(subview: passwordTextField)
    }
    
    func setupRepeatPasswordTextField() {
        repeatPasswordTextField = UITextField()
        repeatPasswordTextField.placeholder = "Repeat Password"
        repeatPasswordTextField.isSecureTextEntry = true
        repeatPasswordTextField.borderStyle = .roundedRect
        addSubviewToContainer(subview: repeatPasswordTextField)
    }
    
    func setupRegisterButton() {
        registerButton = UIButton(type: .roundedRect)
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .systemBlue
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 10
        registerButton.layer.masksToBounds = true
        registerButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        addSubviewToContainer(subview: registerButton)
    }
    
    func setupErrorLabel() {
        errorLabel = UILabel()
        errorLabel.font = UIFont.systemFont(ofSize: 16)
        errorLabel.textColor = .systemRed
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        addSubviewToContainer(subview: errorLabel)
    }
    
    func addSubviewToContainer(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.contentWrapper.addSubview(subview)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 48),
            nameTextField.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 48),
            nameTextField.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -48),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            
            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            
            registerButton.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 24),
            registerButton.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 12),
            errorLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
