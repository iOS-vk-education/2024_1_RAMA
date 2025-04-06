//
//  UserRepository.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 12.03.2025.
//


import Foundation

// MARK: - Domain Layer - Repository Interfaces

protocol UserRepository {
    func login(email: String, password: String) async throws -> User
    func register(email: String, password: String) async throws -> Bool
    func getCurrentUser() async throws -> User
    func updateUser(user: User) async throws -> User
    func logout()
    func isAuthenticated() -> Bool
}
