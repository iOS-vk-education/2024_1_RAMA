//
//  RegService.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 09.05.2025.
//

import Foundation
import Firebase
import FirebaseAuth

class RegService {
    
    private let database = Database.database().reference()
    
    func createNewUser(user: User, password: String, completion: @escaping (Result<String?, Error>) -> Void){
        // Проверяем пароль
        guard password.count >= 6 else {
            let error = NSError(domain: "RegService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Пароль должен содержать минимум 6 символов"])
            completion(.failure(error))
            return
        }
        
        print("RegService: Попытка создания пользователя с email: \(user.email)")
        
        Auth.auth().createUser(withEmail: user.email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                print("RegService: Ошибка создания пользователя: \(error.localizedDescription)")
                print("RegService: Код ошибки: \((error as NSError).code)")
                completion(.failure(error))
                return
            }
            
            if let firebaseUser = result?.user {
                print("RegService: Пользователь успешно создан с UID: \(firebaseUser.uid)")
                
                // Сохраняем данные пользователя в Realtime Database
                let userData: [String: Any] = [
                    "first_name": user.first_name ?? "",
                    "last_name": user.last_name ?? "",
                    "email": user.email,
                    "auth_type": user.auth_type.rawValue,
                    "group_id": user.group_id,
                    "role": user.role,
                    "bio": user.bio ?? "",
                    "course": user.course ?? 0,
                    "institute": user.institute ?? ""
                ]
                
                print("RegService: Сохраняем данные пользователя в Firebase")
                print("RegService: Данные для сохранения: \(userData)")
                
                self.database.child("users").child(firebaseUser.uid).setValue(userData) { error, _ in
                    if let error = error {
                        print("RegService: Ошибка сохранения данных в Firebase: \(error.localizedDescription)")
                        completion(.failure(error))
                    } else {
                        print("RegService: Данные успешно сохранены в Firebase")
                        firebaseUser.sendEmailVerification()
                        completion(.success(firebaseUser.uid))
                    }
                }
            } else {
                let error = NSError(domain: "RegService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Не удалось создать пользователя"])
                print("RegService: Не удалось получить данные созданного пользователя")
                completion(.failure(error))
            }
        }
    }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            print("Error signing out: \(error)")
            completion(.failure(error))
        }
    }
    
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "RegService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Нет активного пользователя"])))
            return
        }
        
        // запрос пароля для удаления аккаунта
        let alert = UIAlertController(
            title: "Подтверждение",
            message: "Для удаления аккаунта введите ваш пароль",
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.placeholder = "Пароль"
            textField.isSecureTextEntry = true
        }
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel) { _ in
            completion(.failure(NSError(domain: "RegService", code: -2, userInfo: [NSLocalizedDescriptionKey: "Операция отменена пользователем"])))
        })
        
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            guard let password = alert.textFields?.first?.text else {
                completion(.failure(NSError(domain: "RegService", code: -3, userInfo: [NSLocalizedDescriptionKey: "Пароль не введен"])))
                return
            }
            
            let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: password)
            
            user.reauthenticate(with: credential) { result, error in
                if let error = error {
                    print("Error reauthenticating: \(error)")
                    completion(.failure(error))
                    return
                }
                
                user.delete { error in
                    if let error = error {
                        print("Error deleting account: \(error)")
                        completion(.failure(error))
                        return
                    }
                    
                    completion(.success(()))
                }
            }
        })
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(alert, animated: true)
        } else {
            completion(.failure(NSError(domain: "RegService", code: -4, userInfo: [NSLocalizedDescriptionKey: "Не удалось отобразить диалог подтверждения"])))
        }
    }
}
