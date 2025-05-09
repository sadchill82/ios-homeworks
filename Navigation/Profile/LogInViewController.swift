//
//  LoginViewController.swift
//  Navigation
//

import UIKit

final class LoginViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate?
    
    private var loginViewModel: LoginViewModel!
    
    // MARK: Visual content
    
    var loginScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var vkLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vkLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var loginStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.layer.borderColor = UIColor.palette.borderColor.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = LayoutConstants.cornerRadius
        stack.distribution = .fillProportionally
        stack.backgroundColor = .palette.textFieldBackground
        stack.clipsToBounds = true
        return stack
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("sign_in".localized, for: .normal)
        button.setTitleColor(.palette.buttonTextColor, for: .normal)
        button.backgroundColor = .palette.buttonBackground
        button.layer.cornerRadius = LayoutConstants.cornerRadius
        button.clipsToBounds = true
        return button
    }()
    
    var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("sign_up".localized, for: .normal)
        button.setTitleColor(.palette.buttonTextColor, for: .normal)
        button.backgroundColor = .palette.buttonGreenBackground
        button.layer.cornerRadius = LayoutConstants.cornerRadius
        button.clipsToBounds = true
        return button
    }()
    
    var loginField: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.placeholder = "email".localized
        login.layer.borderColor = UIColor.palette.borderColor.cgColor
        login.layer.borderWidth = 0.25
        login.leftViewMode = .always
        login.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: login.frame.height))
        login.keyboardType = .emailAddress
        login.textColor = .palette.textColor
        login.font = UIFont.systemFont(ofSize: 16)
        login.autocapitalizationType = .none
        login.returnKeyType = .done
        return login
    }()
    
    var passwordField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.placeholder = "password".localized
        password.layer.borderColor = UIColor.palette.borderColor.cgColor
        password.layer.borderWidth = 0.25
        password.leftViewMode = .always
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: password.frame.height))
        password.isSecureTextEntry = true
        password.textColor = .palette.textColor
        password.font = UIFont.systemFont(ofSize: 16)
        password.autocapitalizationType = .none
        password.returnKeyType = .done
        return password
    }()
    
    // MARK: - Setup section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .palette.background
        navigationController?.navigationBar.isHidden = true
        
        if let delegate = delegate {
            loginViewModel = LoginViewModel(delegate: delegate)
        } else {
            assertionFailure("delegate должен быть задан")
        }
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        
        contentView.addSubviews(vkLogo, loginStackView, loginButton, signUpButton)
        
        loginStackView.addArrangedSubview(loginField)
        loginStackView.addArrangedSubview(passwordField)
        
        loginField.delegate = self
        passwordField.delegate = self
        
        loginButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: loginScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: loginScrollView.centerYAnchor),
            
            vkLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            vkLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkLogo.heightAnchor.constraint(equalToConstant: 100),
            vkLogo.widthAnchor.constraint(equalToConstant: 100),
            
            loginStackView.topAnchor.constraint(equalTo: vkLogo.bottomAnchor, constant: 120),
            loginStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            loginStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            loginStackView.heightAnchor.constraint(equalToConstant: 100),
            
            loginButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: LayoutConstants.indent),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: LayoutConstants.indent),
            signUpButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            signUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // MARK: - Event handlers
    
    @objc private func signInTapped() {
        guard let email = loginField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            showAlert(title: "error".localized, message: "please_fill_in_both_fields".localized)
            return
        }
        
        loginViewModel.signIn(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.navigateToProfile()
                case .failure(let error):
                    self?.showAlert(title: "sign_in_failed".localized, message: error.localizedDescription)
                }
            }
        }
    }
    
    @objc private func signUpTapped() {
        guard let email = loginField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            showAlert(title: "error".localized, message: "please_fill_in_both_fields".localized)
            return
        }
        
        loginViewModel.signUp(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.showAlert(title: "success".localized, message: "user_registered_successfully".localized)
                case .failure(let error):
                    self?.showAlert(title: "sign_up_failed".localized, message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Navigation and Alerts
    
    private func navigateToProfile() {
        let profileVC = ProfileViewController()
        navigationController?.setViewControllers([profileVC], animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok".localized, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extension

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
