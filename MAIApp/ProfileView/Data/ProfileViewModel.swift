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
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var bio: String = ""
    @Published var authType: String = ""
    @Published var course: Int = 0
    @Published var groupId: String = ""
    @Published var institute: String = ""
    @Published var role: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var isLoading: Bool = false
    @Published var authMessage: String? = nil
    @Published var favoriteGroups: [String] = []

    var firstAndLastNames: String {
        if !firstName.isEmpty && !lastName.isEmpty {
            return "\(firstName) \(lastName)"
        } else if !firstName.isEmpty {
            return firstName
        } else if !lastName.isEmpty {
            return lastName
        } else {
            return ""
        }
    }

    private let regService = RegService()
    private let database = Database.database().reference()

    private var cancellables = Set<AnyCancellable>()
    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle? 
    

    init() {
        // Восстанавливаем состояние авторизации из UserDefaults
        if let savedEmail = UserDefaults.standard.string(forKey: "userEmail") {
            self.email = savedEmail
        }
        
        addAuthStateListener()
        checkIfUserIsLoggedIn()
    }

    deinit {
        removeAuthStateListener()
    }

    private func checkIfUserIsLoggedIn() {
        if let currentUser = Auth.auth().currentUser {
            self.isLoggedIn = true
            self.email = currentUser.email ?? ""
            print("ProfileViewModel: Проверка данных пользователя для UID: \(currentUser.uid)")
            
            // Сохраняем email в UserDefaults
            UserDefaults.standard.set(currentUser.email, forKey: "userEmail")
            
            // Загружаем данные пользователя из Firebase Database
            database.child("users").child(currentUser.uid).observeSingleEvent(of: .value) { [weak self] snapshot in
                if let userData = snapshot.value as? [String: Any] {
                    print("ProfileViewModel: Получены данные пользователя: \(userData)")
                    DispatchQueue.main.async {
                        self?.firstName = userData["first_name"] as? String ?? ""
                        self?.lastName = userData["last_name"] as? String ?? ""
                        self?.bio = userData["bio"] as? String ?? ""
                        self?.authType = userData["auth_type"] as? String ?? ""
                        self?.course = userData["course"] as? Int ?? 0
                        self?.groupId = userData["group_id"] as? String ?? ""
                        self?.institute = userData["institute"] as? String ?? ""
                        self?.role = userData["role"] as? String ?? ""
                        
                        print("ProfileViewModel: Загружены данные пользователя:")
                        print("ProfileViewModel: Имя: \(self?.firstName ?? "не указано")")
                        print("ProfileViewModel: Фамилия: \(self?.lastName ?? "не указана")")
                        
                        if let favorites = userData["favorite_groups"] as? [String] {
                            self?.favoriteGroups = favorites
                        }
                    }
                } else {
                    print("ProfileViewModel: Данные пользователя не найдены в Firebase")
                }
            }
            print("ProfileViewModel: Пользователь уже вошел в систему: \(self.email)")
        } else {
            self.isLoggedIn = false
            self.favoriteGroups = []
            // Очищаем сохраненный email при выходе
            UserDefaults.standard.removeObject(forKey: "userEmail")
            print("ProfileViewModel: Нет активного пользователя при запуске.")
        }
    }

    private func addAuthStateListener() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let user = user {
                    self.isLoggedIn = true
                    self.email = user.email ?? ""
                    print("ProfileViewModel (Listener): Пользователь вошел: \(self.email)")
                    self.authMessage = nil
                    
                    // Загружаем данные пользователя при изменении состояния авторизации
                    self.checkIfUserIsLoggedIn()
                } else {
                    self.isLoggedIn = false
                    self.firstName = ""
                    self.lastName = ""
                    self.bio = ""
                    self.authType = ""
                    self.course = 0
                    self.groupId = ""
                    self.institute = ""
                    self.role = ""
                    self.favoriteGroups = []
                    // Очищаем сохраненный email при выходе
                    UserDefaults.standard.removeObject(forKey: "userEmail")
                    print("ProfileViewModel (Listener): Пользователь вышел или сессия не найдена.")
                }
            }
        }
    }


    private func removeAuthStateListener() {
        if let handle = authStateDidChangeListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
            print("ProfileViewModel: AuthStateDidChangeListener удален.")
        }
    }

    func login(email: String, password: String, completion: @escaping (Result<TokenInfo, Error>) -> Void) {
        // Создаем URL для запроса
        guard let url = URL(string: "\(baseURL)/v1/auth/register") else {
            completion(.failure(NSError(domain: "APIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Неверный URL"])))
            return
        }
        
        let parameters = ["email": email, "password": password]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Отправляемые данные: \(jsonString)")
            }
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка запроса: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            // Выводим информацию о запросе для отладки
            if let httpResponse = response as? HTTPURLResponse {
                print("Код ответа: \(httpResponse.statusCode)")
            }
            
            // Выводим тело ответа для отладки
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Тело ответа: \(responseString)")
            }
            
            // Проверяем статус ответа
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "APIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Неверный ответ"])))
                return
            }
            
            // Обрабатываем ответ в зависимости от статуса
            if (200...299).contains(httpResponse.statusCode) {
                // Успешный ответ
                if let data = data {
                    do {
                        // Пытаемся распарсить JSON в TokenInfo
                        let tokenInfo = try JSONDecoder().decode(TokenInfo.self, from: data)
                        print("Успешная регистрация: \(tokenInfo)")
                        completion(.success(tokenInfo))
                    } catch {
                        print("Ошибка парсинга JSON: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NSError(domain: "APIService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Пустой ответ"])))
                }
            } else if httpResponse.statusCode == 409 {
                // Пользователь уже существует
                completion(.failure(NSError(domain: "APIService", code: 409, userInfo: [NSLocalizedDescriptionKey: "Пользователь с таким email уже существует"])))
            } else {
                // Другая ошибка
                let errorMessage = "Ошибка сервера: \(httpResponse.statusCode)"
                print(errorMessage)
                
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Тело ошибки: \(responseString)")
                }
                
                completion(.failure(NSError(domain: "APIService", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
            }
        }.resume()
    }
    
    
    func loginUser() {
        isLoading = true
        authMessage = nil
        
        let emailToSignIn = self.email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        print("ProfileViewModel: Попытка входа с email: \(emailToSignIn)")
        print("ProfileViewModel: Длина пароля: \(password.count)")
        
        // Проверяем пароль
//        guard password.count >= 6 else {
//            self.isLoading = false
//            self.authMessage = "Пароль должен содержать минимум 6 символов"
//            print("ProfileViewModel: Ошибка - пароль слишком короткий")
//            return
//        }
        
        Auth.auth().signIn(withEmail: emailToSignIn, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error as NSError? {
                    self.authMessage = "Ошибка входа: \(error.localizedDescription)"
                    print("ProfileViewModel: Ошибка входа - \(error.localizedDescription)")
                    print("ProfileViewModel: Код ошибки - \(error.code)")
                    print("ProfileViewModel: Детали ошибки - \(error.userInfo)")
                    self.isLoggedIn = false
                    return
                }
                // Success
                self.authMessage = nil
                self.isLoggedIn = true
                print("ProfileViewModel: Успешный вход. UID: \(authResult?.user.uid ?? "N/A")")
                
                // Загружаем данные пользователя после успешного входа
                self.checkIfUserIsLoggedIn()
                
                NotificationCenter.default.post(name: .userDidLogin, object: nil)
            }
        }
    }


    func registerUser() {
        isLoading = true
        authMessage = nil
        let user = User(email: email, first_name: firstName, last_name: lastName)
        print("ProfileViewModel: Попытка регистрации с email: \(email)")

        regService.createNewUser(user: user, password: password) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let userId):
                    // Сохраняем данные пользователя в Firebase Database
                    if let userId = userId {
                        let userData: [String: Any] = [
                            "first_name": self.firstName,
                            "last_name": self.lastName,
                            "email": self.email,
                            "auth_type": user.auth_type.rawValue,
                            "group_id": user.group_id,
                            "role": user.role,
                            "bio": user.bio,
                            "course": user.course,
                            "institute": user.institute
                        ]
                        print("ProfileViewModel: Сохраняем данные в Firebase для пользователя \(userId)")
                        print("ProfileViewModel: Данные для сохранения: \(userData)")
                        
                        self.database.child("users").child(userId).setValue(userData) { error, _ in
                            if let error = error {
                                print("ProfileViewModel: Ошибка сохранения данных в Firebase: \(error)")
                            } else {
                                print("ProfileViewModel: Данные успешно сохранены в Firebase")
                            }
                        }
                    }
                    self.authMessage = "Регистрация успешна! Проверьте почту для подтверждения."
                    print("ProfileViewModel: Регистрация успешна. Письмо для подтверждения отправлено.")
                    self.password = ""
                    self.isLoggedIn = true
                    NotificationCenter.default.post(name: .userDidLogin, object: nil)
                case .failure(let error):
                    self.authMessage = "Ошибка регистрации: \(error.localizedDescription)"
                    print("ProfileViewModel: Ошибка регистрации: \(error.localizedDescription)")
                }
            }
        }
    }
    

    func logoutUser() {
        isLoading = true
        regService.signOut { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    self.isLoggedIn = false
                    self.email = ""
                    self.password = ""
                    self.authMessage = nil
                    // Очищаем сохраненный email при выходе
                    UserDefaults.standard.removeObject(forKey: "userEmail")
                    print("ProfileViewModel: Пользователь успешно вышел из системы.")
                case .failure(let error):
                    self.authMessage = "Ошибка при выходе: \(error.localizedDescription)"
                    print("ProfileViewModel: Ошибка при выходе из системы: \(error.localizedDescription)")
                }
            }
        }
    }

    func deleteAccount() {
        isLoading = true
        authMessage = nil
        
        regService.deleteAccount { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    self.isLoggedIn = false
                    self.email = ""
                    self.password = ""
                    self.authMessage = "Аккаунт успешно удален"
                    print("ProfileViewModel: Аккаунт успешно удален")
                case .failure(let error):
                    self.authMessage = "Ошибка при удалении аккаунта: \(error.localizedDescription)"
                    print("ProfileViewModel: Ошибка при удалении аккаунта: \(error.localizedDescription)")
                }
            }
        }
    }

    func updateUserProfile(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "ProfileViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Нет активного пользователя"])))
            return
        }
        
        let userData: [String: Any] = [
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "bio": bio,
            "auth_type": authType,
            "course": course,
            "group_id": groupId,
            "institute": institute,
            "role": role
        ]
        
        database.child("users").child(currentUser.uid).updateChildValues(userData) { error, _ in
            if let error = error {
                print("Error updating user data: \(error)")
                completion(.failure(error))
            } else {
                print("User data updated successfully")
                completion(.success(()))
            }
        }
    }

    // Функция для добавления группы в избранное
    func addToFavorites(groupId: String) {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        if !favoriteGroups.contains(groupId) {
            favoriteGroups.append(groupId)
            updateFavoritesInFirebase()
        }
    }
    
    // Функция для удаления группы из избранного
    func removeFromFavorites(groupId: String) {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        favoriteGroups.removeAll { $0 == groupId }
        updateFavoritesInFirebase()
    }
    
    // Функция для обновления избранных групп в Firebase
    private func updateFavoritesInFirebase() {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        database.child("users").child(currentUser.uid).updateChildValues([
            "favorite_groups": favoriteGroups
        ]) { error, _ in
            if let error = error {
                print("Ошибка обновления избранных групп: \(error)")
            } else {
                print("Избранные группы успешно обновлены")
            }
        }
    }
}

extension Notification.Name {
    static let userDidLogin = Notification.Name("userDidLogin")
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
