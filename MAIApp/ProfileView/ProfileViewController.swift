import UIKit
import SwiftUI

class ProfileViewController: UIViewController {
    private let profileVM: ProfileViewModel
    private let groupSelectionViewModel: GroupSelectionViewModel
    private let weekViewModel: DateViewModel
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let firstAndLastNames: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(profileVM: ProfileViewModel, groupSelectionViewModel: GroupSelectionViewModel, weekViewModel: DateViewModel) {
        self.profileVM = profileVM
        self.groupSelectionViewModel = groupSelectionViewModel
        self.weekViewModel = weekViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Профиль"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(firstAndLastNames)
        contentView.addSubview(settingsLabel)
        contentView.addSubview(stackView)
        
        firstAndLastNames.text = profileVM.firstName + " " + profileVM.lastName
        
        setupConstraints()
        setupButtons()
    }
    
    private func setupNavigationBar() {
        let themeButton = UIBarButtonItem(image: UIImage(systemName: "circle.lefthalf.filled"), style: .plain, target: self, action: #selector(showThemePicker))
//        let notificationButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(notificationTapped))
        
        navigationItem.rightBarButtonItems = [themeButton]
    }
    
    private func setupButtons() {
        let appIconButton = SettingsButton(title: "Изменить иконку приложения")
        appIconButton.addTarget(self, action: #selector(appIconTapped), for: .touchUpInside)
        
//        let groupButton = SettingsButton(title: "Изменить группу")
//        groupButton.addTarget(self, action: #selector(groupTapped), for: .touchUpInside)
        
        let logoutButton = SettingsButton(title: "Выйти из аккаунта", isDestructive: true)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        
        let deleteAccountButton = SettingsButton(title: "Удалить аккаунт", isDestructive: true)
        deleteAccountButton.addTarget(self, action: #selector(deleteAccountTapped), for: .touchUpInside)
        
        let spacing: CGFloat = 15
        stackView.spacing = spacing
        
        stackView.addArrangedSubview(appIconButton)
//        stackView.addArrangedSubview(groupButton)
        stackView.addArrangedSubview(logoutButton)
        stackView.addArrangedSubview(deleteAccountButton)
        
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            firstAndLastNames.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            firstAndLastNames.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            settingsLabel.topAnchor.constraint(equalTo: firstAndLastNames.bottomAnchor, constant: 30),
            settingsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            stackView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func appIconTapped() {
        let chooseAppIconView = ChooseAppIconView()
        navigationController?.pushViewController(UIHostingController(rootView: chooseAppIconView), animated: true)
    }
    
    @objc private func groupTapped() {
        let chooseGroupView = ChooseGroupView(groupSelectionViewModel: groupSelectionViewModel, dateViewModel: weekViewModel)
        navigationController?.pushViewController(UIHostingController(rootView: chooseGroupView), animated: true)
    }
    
    @objc private func logoutTapped() {
        profileVM.logoutUser()
    }
    
    @objc private func notificationTapped() {
        // уведы 
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
    
    @objc private func deleteAccountTapped() {
        let alert = UIAlertController(
            title: "Удаление аккаунта",
            message: "Вы уверены, что хотите удалить свой аккаунт? Это действие нельзя отменить.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            self?.profileVM.deleteAccount()
        })
        
        present(alert, animated: true)
    }
} 
