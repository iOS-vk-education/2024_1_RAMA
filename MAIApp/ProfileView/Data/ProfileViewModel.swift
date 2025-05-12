//
//  ProfileViewModel.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 12.03.2025.
//


import SwiftUI
import Combine
import Firebase
import FirebaseAuth

class ProfileViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var isLoading: Bool = false
    @Published var authMessage: String? = nil

    private let regService = RegService()

    private var cancellables = Set<AnyCancellable>()
    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle? 
    

    init() {
            addAuthStateListener()
        }

        deinit {
            removeAuthStateListener()
        }

        // --- Метод для проверки текущего пользователя (используется при запуске) ---
        private func checkIfUserIsLoggedIn() {
            if let currentUser = Auth.auth().currentUser {
                self.isLoggedIn = true
                self.email = currentUser.email ?? ""
                print("ProfileViewModel: Пользователь уже вошел в систему: \(self.email)")
            } else {
                self.isLoggedIn = false
                print("ProfileViewModel: Нет активного пользователя при запуске.")
            }
        }

        // --- Метод для добавления слушателя состояния аутентификации ---
        private func addAuthStateListener() {
            authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if let user = user {
                        self.isLoggedIn = true
                        self.email = user.email ?? ""
                        print("ProfileViewModel (Listener): Пользователь вошел: \(self.email)")
                        self.authMessage = nil
                    } else {
                
                        self.isLoggedIn = false
                        print("ProfileViewModel (Listener): Пользователь вышел или сессия не найдена.")
                    }
                }
            }
        }

        // --- Метод для удаления notificationcenter и отписки от listener'ов при выходе  ---
        private func removeAuthStateListener() {
            if let handle = authStateDidChangeListenerHandle {
                Auth.auth().removeStateDidChangeListener(handle)
                print("ProfileViewModel: AuthStateDidChangeListener удален.")
            }
        }


    func loginUser() {
        isLoading = true
        authMessage = nil
        
        let emailToSignIn = self.email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        Auth.auth().signIn(withEmail: emailToSignIn, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error as NSError? {
                    self.authMessage = "Ошибка входа: \(error.localizedDescription)"
                    print("Firebase Auth Error: \(error)")
                    print("Error code: \(error.code)")
                    print("Localized description: \(error.localizedDescription)")
                    print("User info: \(error.userInfo)")
                    self.isLoggedIn = false
                    return
                }
                // Success
                self.authMessage = nil
                self.isLoggedIn = true
                print("User signed in successfully: \(authResult?.user.uid ?? "N/A")")
            }
        }
    }


    func registerUser() {
        isLoading = true
        authMessage = nil
        let userData = UserData(email: email, password: password)
        print("ProfileViewModel: Попытка регистрации с email: \(email)")

        regService.createNewUser(user: userData) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success:
                    self.authMessage = "Регистрация успешна! Проверьте почту для подтверждения."
                    print("ProfileViewModel: Регистрация успешна. Письмо для подтверждения отправлено.")
                    self.password = ""
                case .failure(let error):
                    self.authMessage = "Ошибка регистрации: \(error.localizedDescription)"
                    print("ProfileViewModel: Ошибка регистрации: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // --- Логика Выхода ---
    func logoutUser() {
        isLoading = true
        regService.signOut() 
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isLoading = false
            self.isLoggedIn = false
            self.email = ""
            self.password = ""
            self.authMessage = nil
            print("ProfileViewModel: Пользователь вышел из системы.")
        }
    }
}

//import Foundation
//import SwiftUI
//
//final class ProfileViewModel: ObservableObject {
//    @Published var email: String = ""
//    @Published var password: String = ""
//    @Published var passwordVerifiсation: String = ""
//    @Published var isLoading: Bool = false
//    @Published var isLoggedIn: Bool = false
//    @Published var accessToken: String = ""
//    @Published var refreshToken: String = ""
//    
//    @Published var name: String = "Михаил Рахимов" // Default or fetched
//    @Published var group: String = "М8О-101БВ-24" // Default or fetched
//    
//    let apiService = APIService() // Make sure APIService is accessible and has a login method
//    
//    func register() {
////        guard !email.isEmpty, !password.isEmpty else {
////            print("Email или пароль пустые")
////            return
////        }
////        
////        self.isLoading = true
////        apiService.register(email: email, password: password) { [weak self] result in
////            DispatchQueue.main.async {
////                self?.isLoading = false
////                
////                switch result {
////                case .success(let tokenInfo):
////                    self?.accessToken = tokenInfo.access_token
////                    self?.refreshToken = tokenInfo.refresh_token
////                    self?.isLoggedIn = true
////                    print("Регстрация прошла успешно: \(tokenInfo)")
////                    self?.getUserInfo() // Fetch user info after successful registration
////                case .failure(let error):
////                    print("Ошибка регистрации: \(error.localizedDescription)")
////                }
////            }
////            
////        }
//    }
//
//    func login() {
////        guard !email.isEmpty, !password.isEmpty else {
////            print("Email or password empty for login")
////            return
////        }
////        
////        self.isLoading = true
////        // Assuming APIService has a login method similar to register
////        apiService.login(email: email, password: password) { [weak self] result in
////            DispatchQueue.main.async {
////                self?.isLoading = false
////                switch result {
////                case .success(let tokenInfo):
////                    self?.accessToken = tokenInfo.access_token
////                    self?.refreshToken = tokenInfo.refresh_token
////                    self?.isLoggedIn = true
////                    print("Вход выполнен успешно: \(tokenInfo)")
////                    self?.getUserInfo() // Fetch user info after successful login
////                case .failure(let error):
////                    print("Ошибка входа: \(error.localizedDescription)")
////                }
////            }
////        }
//    }
//    
//    func getUserInfo() {
////            guard !accessToken.isEmpty else {
////                print("Токен не найден")
////                return
////            }
////            
////            apiService.getUserInfo(token: accessToken) { [weak self] result in
////                DispatchQueue.main.async {
////                    switch result {
////                    case .success(let json):
////                        if let name = json["name"] as? String {
////                            self?.name = name
////                        }
////                        if let group = json["group"] as? String {
////                            self?.group = group
////                        }
////                        print("Информация о пользователе получена: \(json)")
////                    case .failure(let error):
////                        print("Ошибка получения информации о пользователе: \(error.localizedDescription)")
////                    }
////                }
////            }
//        }
//    
//    func logout() {
////        // Clear tokens and user data
////        self.accessToken = ""
////        self.refreshToken = ""
////        self.email = "" // Optionally clear email/password fields
////        self.password = ""
////        self.name = "Михаил Рахимов" // Reset to default or empty
////        self.group = "М8О-101БВ-24"  // Reset to default or empty
////        self.isLoggedIn = false
////        print("Logged out")
////        // Here you might also want to call an API endpoint to invalidate the token on the server.
//    }
//    
//}
