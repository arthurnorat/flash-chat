//
//  RegisterViewModel.swift
//  FlashChat
//
//  Created by Arthur Norat on 20/10/25.
//

import SwiftUI
import Combine
import Amplify

class RegisterViewModel: ObservableObject {
	
	// MARK: Published Properties
	@Published var email: String = ""
	@Published var password: String = ""
//	@Published var isLoading: Bool = false TODO: - Implement loading state
	@Published var errorMessage: String?
	@Published var isRegistrationSuccessful: Bool = false
	@Published var needsConfirmation: Bool = false
	@Published var confirmationCode: String = ""
	
	// MARK: Registration Logic
	
	func register() {
		// 1. Basic validation
		guard !email.isEmpty, !password.isEmpty else {
			errorMessage = "Email and password cannot be empty."
			return
		}

		guard password.count >= 8 else {
			errorMessage = "Password must be at least 8 characters long."
			return
		}

		// 2. Prepare to make the request
//		isLoading = true
		errorMessage = nil

		// 3. Configure user attributes
		let userAttributes = [AuthUserAttribute(.email, value: email)]
		let options = AuthSignUpRequest.Options(userAttributes: userAttributes)

		// 4. Call Amplify Auth
		Amplify.Auth.signUp(username: email, password: password, options: options) { [weak self] result in
			// 5. Return to main thread to update UI
			DispatchQueue.main.async {
				guard let self = self else { return }

				// 6. Stop loading
//				self.isLoading = false

				// 7. Handle the result
				switch result {
				case .success(let signUpResult):
					self.handleSignUpResult(signUpResult)

				case .failure(let error):
					self.handleAuthError(error)
				}
			}
		}
	}
	
	func confirmSignUp() {
		guard !confirmationCode.isEmpty else {
			errorMessage = "Insert your 6 digits confirmation code"
			return
		}
		
		Amplify.Auth.confirmSignUp(for: email, confirmationCode: confirmationCode) { [weak self] result in
			DispatchQueue.main.async {
				guard let self = self else { return }
				
				switch result {
				case .success(let confirmResult):
					self.isRegistrationSuccessful = true
					
				case .failure(let error):
					self.handleAuthError(error)
				}
				
			}
		}
	}
	
	// MARK: Private Helper Methods
	private func handleSignUpResult(_ signUpResult: AuthSignUpResult) {
		switch signUpResult.nextStep {
		case .confirmUser(let deliveryDetails, _):
			// Cognito sent confirmation code via email
			errorMessage = "Please confirm your account via \(deliveryDetails?.destination)."
			print("Code sent to \(deliveryDetails)")
			needsConfirmation = true

		case .done:
			isRegistrationSuccessful = true
		@unknown default:
			errorMessage = "An unknown error occurred during registration."
		}
	}
	
	private func handleAuthError(_ error: AuthError) {
			switch error {
			case .service(_, _, let underlyingError):
				// AWS Cognito errors
				if let cognitoError = underlyingError {
					let errorDesc = cognitoError.localizedDescription

					if errorDesc.contains("UsernameExistsException") {
						errorMessage = "❌ This email is already registered"
					} else if errorDesc.contains("InvalidPasswordException") {
						errorMessage = "❌ Password does not meet requirements"
					} else {
						errorMessage = "❌ Service error: \(errorDesc)"
					}
				} else {
					errorMessage = "❌ Unknown service error"
				}

			case .validation:
				errorMessage = "❌ Invalid data. Check email and password."

			default:
				errorMessage = "❌ Unexpected error: \(error.localizedDescription)"
			}

			// Debug log
			print("❌ Full AuthError: \(error)")
		}
}
