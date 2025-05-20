//
//  AuthViewController.swift
//  MAIApp
//
//  Created by Михаил Рахимов on 25.04.2025.
//

import Foundation
import UIKit
import SwiftUI

struct AuthView2Representable: UIViewControllerRepresentable {
    @ObservedObject var viewModel: ProfileViewModel
    var onNavigateToRegistration: () -> Void
    var onAuthFinished: () -> Void

    func makeUIViewController(context: Context) -> AuthView2Controller {
        let vc = AuthView2Controller()
        vc.viewModel = viewModel
        vc.delegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: AuthView2Controller, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, AuthView2ControllerDelegate {
        var parent: AuthView2Representable
        init(_ parent: AuthView2Representable) { self.parent = parent }
        func didSuccessfullyLogin() { parent.onAuthFinished() }
        func navigateToRegistration() { parent.onNavigateToRegistration() }
    }
}

// RegView2Representable.swift
import SwiftUI

struct RegView2Representable: UIViewControllerRepresentable {
    @ObservedObject var viewModel: ProfileViewModel
    var onNavigateToLogin: () -> Void
    var onRegistrationFinished: () -> Void

    func makeUIViewController(context: Context) -> RegView2Controller {
        let vc = RegView2Controller()
        vc.viewModel = viewModel
        vc.delegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: RegView2Controller, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, RegView2ControllerDelegate {
        var parent: RegView2Representable
        init(_ parent: RegView2Representable) { self.parent = parent }
        func didSuccessfullyRegister() { parent.onRegistrationFinished() }
        func navigateToLogin() { parent.onNavigateToLogin() }
    }
}



import SwiftUI

struct AuthContainerView: View {
    @ObservedObject var profileVM: ProfileViewModel
    
    enum AuthScreen {
        case login, registration
    }
    @State private var currentScreen: AuthScreen = .login

    var body: some View {
        ZStack {
            if currentScreen == .login {
                AuthView2Representable(
                    viewModel: profileVM,
                    onNavigateToRegistration: {
                        profileVM.authMessage = nil
                        currentScreen = .registration
                    },
                    onAuthFinished: {
                        print("AuthContainerView: Вход успешен, переход к профилю.")
                    }
                )
            } else {
                RegView2Representable(
                    viewModel: profileVM,
                    onNavigateToLogin: {
                        profileVM.authMessage = nil 
                        currentScreen = .login
                    },
                    onRegistrationFinished: {
                        // Можно добавить задержку и автоматический переход на экран входа
                         DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                             if profileVM.authMessage?.contains("Регистрация успешна") ?? false {
                                 self.currentScreen = .login
                             }
                         }
                        print("AuthContainerView: Регистрация завершена.")
                    }
                )
            }
        }
        .ignoresSafeArea(.keyboard)
        .onAppear {
            if !profileVM.isLoggedIn {
                 profileVM.authMessage = nil
            }
        }
    }
}

