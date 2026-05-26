//
//  LoginViewModel.swift
//  FlashChat
//
//  Created by Arthur Norat on 20/05/26.
//

import SwiftUI
import Combine
import Amplify

class LoginViewModel: ObservableObject {

    // MARK: Published Properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isLoginSuccessful: Bool = false

    // MARK: Login Logic

    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password cannot be empty."
            return
        }

        isLoginSuccessful = false
        errorMessage = nil

        Task {
            do {
                let result = try await Amplify.Auth.signIn(username: email, password: password)
                await MainActor.run {
                    handleSignInResult(result)
                }
            } catch let error as AuthError {
                await MainActor.run {
                    handleAuthError(error)
                }
            }
        }
    }

    // MARK: Private Helper Methods

    private func handleSignInResult(_ result: AuthSignInResult) {
        switch result.nextStep {
        case .done:
            isLoginSuccessful = true
        case .confirmSignUp:
            errorMessage = "Please confirm your email before logging in."
        @unknown default:
            errorMessage = "An unexpected step occurred."
        }
    }

    private func handleAuthError(_ error: AuthError) {
        switch error {
        case .service(_, _, let underlyingError):
            if let cognitoError = underlyingError {
                let errorDesc = cognitoError.localizedDescription
                if errorDesc.contains("NotAuthorizedException") {
                    errorMessage = "❌ Incorrect email or password."
                } else if errorDesc.contains("UserNotFoundException") {
                    errorMessage = "❌ No account found with this email."
                } else {
                    errorMessage = "❌ Service error: \(errorDesc)"
                }
            } else {
                errorMessage = "❌ Unknown service error."
            }
        case .notAuthorized:
            errorMessage = "❌ Incorrect email or password."
        case .validation:
            errorMessage = "❌ Invalid data. Check email and password."
        default:
            errorMessage = "❌ Unexpected error: \(error.localizedDescription)"
        }

        print("❌ Full AuthError: \(error)")
    }
}
