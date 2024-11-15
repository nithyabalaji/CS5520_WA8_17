
import UIKit

class RegisterScreenView: UIView {

    var contentWrapper: UIScrollView!
    var registerLabel: UILabel!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var repeatPasswordTextField: UITextField!
    var registerButton: UIButton!
    var errorLabel: UILabel!
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupContentWrapper()
        setupRegisterLabel()
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupRepeatPasswordTextField()
        setupRegisterButton()
        setupErrorLabel()
        setupViews()
        initConstraints()
    }
    private func setupViews() {
          
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.hidesWhenStopped = true // Automatically hides when stopped
            addSubview(activityIndicator)

            // Layout Constraints for Activity Indicator
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    

    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }

    func setupRegisterLabel() {
        registerLabel = UILabel()
        registerLabel.text = "Register"
        registerLabel.font = UIFont.boldSystemFont(ofSize: 32)
        registerLabel.textColor = .systemBlue
        addSubviewToContainer(subview: registerLabel)
    }

    func setupNameTextField() {
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.font = nameTextField.font?.withSize(16)
        addSubviewToContainer(subview: nameTextField)
    }

    func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.borderStyle = .roundedRect
        emailTextField.font = emailTextField.font?.withSize(16)
        addSubviewToContainer(subview: emailTextField)
    }

    func setupPasswordTextField() {
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.font = passwordTextField.font?.withSize(16)
        addSubviewToContainer(subview: passwordTextField)
    }

    func setupRepeatPasswordTextField() {
        repeatPasswordTextField = UITextField()
        repeatPasswordTextField.placeholder = "Repeat Password"
        repeatPasswordTextField.isSecureTextEntry = true
        repeatPasswordTextField.borderStyle = .roundedRect
        repeatPasswordTextField.font = repeatPasswordTextField.font?.withSize(16)
        addSubviewToContainer(subview: repeatPasswordTextField)
    }

    func setupRegisterButton() {
        registerButton = UIButton(type: .roundedRect)
        registerButton.setTitle("Register", for: .normal)
        setupButton(button: registerButton)
    }

    func setupErrorLabel() {
        errorLabel = UILabel()
        errorLabel.font = UIFont.systemFont(ofSize: 16)
        errorLabel.textColor = .systemRed
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        addSubviewToContainer(subview: errorLabel)
    }

    func setupButton(button: UIButton) {
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        addSubviewToContainer(subview: button)
    }

    func addSubviewToContainer(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(subview)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),

            registerLabel.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 48),
            registerLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            nameTextField.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 16),
            nameTextField.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            emailTextField.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            repeatPasswordTextField.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            registerButton.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 24),
            registerButton.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            errorLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 12),
            errorLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            errorLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentWrapper.bottomAnchor),
        ])
        textFieldConstraints(nameTextField)
        textFieldConstraints(emailTextField)
        textFieldConstraints(passwordTextField)
        textFieldConstraints(repeatPasswordTextField)
    }

    func textFieldConstraints(_ textField: UITextField) {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 48),
            textField.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -48),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
