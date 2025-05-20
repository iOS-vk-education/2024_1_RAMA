//
//  AuthView2.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 09.05.2025.
//

import UIKit
import Combine

protocol AuthView2ControllerDelegate: AnyObject {
    func didSuccessfullyLogin()
    func navigateToRegistration()
}

class AuthView2Controller: UIViewController {

    weak var delegate: AuthView2ControllerDelegate?
    var viewModel: ProfileViewModel! 

    private var cancellables = Set<AnyCancellable>()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.textContentType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var loginButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Войти"
        config.baseBackgroundColor = .systemBlue
        config.cornerStyle = .medium
        let button = UIButton(configuration: config, primaryAction: UIAction { [unowned self] _ in
            self.loginButtonTapped()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var switchToRegisterButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Нет аккаунта? Зарегистрироваться"
        let button = UIButton(configuration: config, primaryAction: UIAction { [unowned self] _ in
            self.delegate?.navigateToRegistration()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var themeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "circle.lefthalf.filled"), style: .plain, target: self, action: #selector(showThemePicker))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupNavigationBar()
        bindViewModel()
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        emailTextField.text = viewModel.email
        passwordTextField.text = viewModel.password
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserDidLogin), name: .userDidLogin, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func handleUserDidLogin() {
        delegate?.didSuccessfullyLogin()
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = themeButton
    }
    
    @objc private func showThemePicker() {
        let alertController = UIAlertController(title: "Выберите тему", message: nil, preferredStyle: .actionSheet)
        
        let systemAction = UIAlertAction(title: "Системная", style: .default) { [weak self] _ in
            self?.setTheme(.system)
        }
        
        let lightAction = UIAlertAction(title: "Светлая", style: .default) { [weak self] _ in
            self?.setTheme(.light)
        }
        
        let darkAction = UIAlertAction(title: "Темная", style: .default) { [weak self] _ in
            self?.setTheme(.dark)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alertController.addAction(systemAction)
        alertController.addAction(lightAction)
        alertController.addAction(darkAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    private func setTheme(_ theme: Theme) {
        UserDefaults.standard.set(theme.rawValue, forKey: "theme")
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = theme == .system ? .unspecified :
                    theme == .light ? .light : .dark
            }
        }
    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel, emailTextField, passwordTextField, loginButton, switchToRegisterButton, messageLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.setCustomSpacing(40, after: titleLabel)
        stackView.setCustomSpacing(30, after: passwordTextField)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            loginButton.heightAnchor.constraint(equalToConstant: 50),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.$email
            .map { $0 }  // Convert to Optional if needed
            .assign(to: \.text, on: emailTextField)
            .store(in: &cancellables)
        
        viewModel.$password
            .map { $0 }  // Convert to Optional if needed
            .assign(to: \.text, on: passwordTextField)
            .store(in: &cancellables)

        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.loginButton.isEnabled = !isLoading
                self?.switchToRegisterButton.isEnabled = !isLoading
                isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }
            .store(in: &cancellables)

        viewModel.$authMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.messageLabel.text = message
                self?.messageLabel.textColor = (message?.contains("Ошибка") ?? false) ? .systemRed : .systemGreen
            }
            .store(in: &cancellables)
        
        viewModel.$isLoggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoggedIn in
                if isLoggedIn {
                    self?.delegate?.didSuccessfullyLogin()
                }
            }
            .store(in: &cancellables)
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField == emailTextField {
            viewModel.email = textField.text ?? ""
        } else if textField == passwordTextField {
            viewModel.password = textField.text ?? ""
        }
    }

    private func loginButtonTapped() {
        view.endEditing(true) // Скрыть клавиатуру
        viewModel.loginUser()
    }
}

