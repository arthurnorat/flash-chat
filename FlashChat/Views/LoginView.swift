//
//  LoginView.swift
//  FlashChat
//
//  Created by Arthur Norat on 20/10/25.
//

import SwiftUI

struct LoginView: View {
    let onLogOut: () -> Void

    @StateObject private var viewModel = LoginViewModel()
    @State private var navigateToChatView: Bool = false

    var body: some View {
        VStack(spacing: 20) {

            Spacer()

            TextField("Digite seu e-mail", text: $viewModel.email)
                .padding()
                .background(Color.white)
                .cornerRadius(25.0)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)

            SecureField("Digite sua senha", text: $viewModel.password)
                .padding()
                .background(Color.white)
                .cornerRadius(25.0)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                .textInputAutocapitalization(.never)

            Button("Login") {
                viewModel.signIn()
            }
            .font(.system(size: 30))
            .foregroundColor(Color(K.BrandColors.blue))
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .background(Color(K.BrandColors.lightBlue))

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 20)
        .background(Color("BrandLightBlue"))
        .ignoresSafeArea()
        .navigationDestination(isPresented: $navigateToChatView) {
            ChatView(onLogOut: {
                navigateToChatView = false
                onLogOut()
            })
        }
        .onChange(of: viewModel.isLoginSuccessful) { _, isSuccessful in
            if isSuccessful {
                navigateToChatView = true
            }
        }
    }
}

#Preview {
    LoginView(onLogOut: {})
}
