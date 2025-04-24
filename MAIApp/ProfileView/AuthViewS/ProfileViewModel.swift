//
//  ProfileViewModel.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 12.03.2025.
//

import Foundation
import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordVerifiсation: String = "" 
    @Published var isLoading: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var accessToken: String = ""
    @Published var refreshToken: String = ""
    
    @Published var name: String = "Михаил Рахимов"
    @Published var group: String = "М8О-101БВ-24"
    
    private let apiService = APIService()
    
    func register() {
        guard !email.isEmpty, !password.isEmpty else {
            print("Email или пароль пустые")
            return
        }
        
        self.isLoading = true
        apiService.register(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let tokenInfo):
                    self?.accessToken = tokenInfo.access_token
                    self?.refreshToken = tokenInfo.refresh_token
                    self?.isLoggedIn = true
                    print("Регстрация прошла успешно: \(tokenInfo)")
                case .failure(let error):
                    print("Ошибка регистрации: \(error.localizedDescription)")
                }
            }
            
        }
    }
    
    func getUserInfo() {
            guard !accessToken.isEmpty else {
                print("Токен не найден")
                return
            }
            
            apiService.getUserInfo(token: accessToken) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let json):
                        if let name = json["name"] as? String {
                            self?.name = name
                        }
                        if let group = json["group"] as? String {
                            self?.group = group
                        }
                        print("Информация о пользователе получена: \(json)")
                    case .failure(let error):
                        print("Ошибка получения информации о пользователе: \(error.localizedDescription)")
                    }
                }
            }
        }
    
    
}


