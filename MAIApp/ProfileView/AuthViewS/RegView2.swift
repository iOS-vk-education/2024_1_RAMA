//
//  RegView2.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 09.05.2025.
//

import UIKit
import Combine

protocol RegView2ControllerDelegate: AnyObject {
    func didSuccessfullyRegister() // Может быть полезно для показа сообщения или авто-перехода
    func navigateToLogin()
}

class RegView2Controller: UIViewController {

    weak var delegate: RegView2ControllerDelegate?
    var viewModel: ProfileViewModel! // Будет внедрен

    private var cancellables = Set<AnyCancellable>()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя"
        textField.borderStyle = .roundedRect
        // textField.autocapitalizationType = .words
        textField.textContentType = .givenName
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Фамилия"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .words
        textField.textContentType = .familyName
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
        textField.placeholder = "Пароль (мин. 6 символов)"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.textContentType = .newPassword // Помогает с автозаполнением и генерацией паролей
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // Опционально: Поле для подтверждения пароля
    // private let confirmPasswordTextField: UITextField = { ... }()

    private lazy var registerButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Зарегистрироваться"
        config.baseBackgroundColor = .systemGreen
        config.cornerStyle = .medium
        let button = UIButton(configuration: config, primaryAction: UIAction { [unowned self] _ in
            self.registerButtonTapped()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var switchToLoginButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Уже есть аккаунт? Войти"
        let button = UIButton(configuration: config, primaryAction: UIAction { [unowned self] _ in
            self.delegate?.navigateToLogin()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        bindViewModel()
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        firstNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        // Установить делегаты для валидации
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Установить начальные значения из ViewModel
        emailTextField.text = viewModel.email
        firstNameTextField.text = viewModel.firstName
        lastNameTextField.text = viewModel.lastName
    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel, firstNameTextField, lastNameTextField, emailTextField, passwordTextField, registerButton, switchToLoginButton, messageLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.setCustomSpacing(40, after: titleLabel)
        stackView.setCustomSpacing(30, after: passwordTextField) // или after: confirmPasswordTextField
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            // confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 44),
            registerButton.heightAnchor.constraint(equalToConstant: 50),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.$email
            .map { $0 as String? }
            .assign(to: \.text, on: emailTextField)
            .store(in: &cancellables)

        viewModel.$firstName
            .map { $0 as String? }
            .assign(to: \.text, on: firstNameTextField)
            .store(in: &cancellables)

        viewModel.$lastName
            .map { $0 as String? }
            .assign(to: \.text, on: lastNameTextField)
            .store(in: &cancellables)

        
        // Не биндим viewModel.password напрямую к passwordTextField.text при загрузке,
        // но обновляем viewModel при изменении текста.

        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.registerButton.isEnabled = !isLoading
                self?.switchToLoginButton.isEnabled = !isLoading
                isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }
            .store(in: &cancellables)

        viewModel.$authMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.messageLabel.text = message
                let isError = message?.contains("Ошибка") ?? false
                let isSuccess = message?.contains("Регистрация успешна") ?? false
                
                if isError {
                    self?.messageLabel.textColor = .systemRed
                } else if isSuccess {
                    self?.messageLabel.textColor = .systemGreen
                } else {
                    self?.messageLabel.textColor = .label // По умолчанию
                }
                
                if isSuccess {
                    self?.delegate?.didSuccessfullyRegister()
                }
            }
            .store(in: &cancellables)
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField == emailTextField {
            viewModel.email = textField.text ?? ""
        } else if textField == passwordTextField {
            viewModel.password = textField.text ?? ""
        } else if textField == firstNameTextField {
            viewModel.firstName = textField.text ?? ""
        } else if textField == lastNameTextField {
            viewModel.lastName = textField.text ?? ""
        }
        // else if textField == confirmPasswordTextField { ... }
    }

    private func registerButtonTapped() {
        view.endEditing(true)
        // Опционально: добавить проверку совпадения паролей, если есть confirmPasswordTextField
        viewModel.registerUser()
    }
}

// MARK: - UITextFieldDelegate
extension RegView2Controller: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Проверяем, является ли поле email или password
        if textField == emailTextField || textField == passwordTextField {
            // Проверяем, содержит ли вводимый текст русские буквы
            let russianLetters = CharacterSet(charactersIn: "абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ")
            let stringSet = CharacterSet(charactersIn: string)
            
            // Если вводимый текст содержит русские буквы, запрещаем ввод
            if stringSet.intersection(russianLetters).isEmpty {
                return true
            } else {
                return false
            }
        }
        return true
    }
}

//class RegView2: UIViewController {
//    private var viewBuilder = ViewBuilder()
//    lazy var titleLable = viewBuilder.createLabel(frame: CGRect(x: 30, y: 100, width: view.frame.width - 60, height: 40),
//                                                  text: "Регистрация",
//                                                  size: 22)
//    lazy var emailTextField = viewBuilder.createTextFielf(frame: CGRect(x: 30, y: titleLable.frame.maxY + 60, width: view.frame.width - 60, height: 50), placeholder: "Email")
//    
//    lazy var passwordTextField = viewBuilder.createTextFielf(frame: CGRect(x: 30, y: emailTextField.frame.maxY + 20, width: view.frame.width - 60, height: 50), placeholder: "Password", isPassword: true)
//    
//    lazy var nameTextFied = viewBuilder.createTextField(frame: CGRect(x: 30, y: passwordTextField.frame.maxY + 20, width: view.frame.width - 60, height: 50), placeholder: "Name")
//    
//    lazy var regAction: UIAction = UIAction { [weak self] _ in
//        guard let self = self else { return }
//        
//        let email = emailTextField.text ?? ""
//        let password = passwordTextField.text ?? ""
//        let name = nameTextFied.text ?? ""
//        
//    }
//    
//    lazy var loginAction: UIAction = UIAction{_ in
//        NotificationCenter.default.post(name: Notification.Name(rawValue: "routeVC"), object: nil, userInfo: ["vc": WindowCase.login])
//    }
//    
//    lazy var regBtn = viewBuilder.createButton(frame: CGRect(x: 30, y: view.frame.height - 150, width: view.frame.width - 60, height: 50), action: regAction, title: "Регистрация", isMainBtn: true)
//    
//    lazy var logBtn = viewBuilder.createButton(frame: CGRect(x: 30, y: view.frame.height - 150, width: view.frame.width - 60, height: 50), action: loginAction, title: "Есть аккаунт")
//}
