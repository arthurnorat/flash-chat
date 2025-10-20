//
//  RegisterView.swift
//  FlashChat
//
//  Created by Arthur Norat on 18/10/25.
//

import SwiftUI

struct RegisterView: View {
	
	@State private var email: String = ""
	@State private var password: String = ""
	
    var body: some View {
		VStack(spacing: 20) {
			
			Spacer()
			
			TextField("Digite seu e-mail", text: $email)
				.padding()
				.background(Color.white)
				.cornerRadius(25.0)
				.shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
				.textInputAutocapitalization(.never)
				.keyboardType(.emailAddress)
			
			SecureField("Digite sua senha", text: $password)
				.padding()
				.background(Color.white)
				.cornerRadius(25.0)
				.shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
				.textInputAutocapitalization(.never)
			
			
			Button("Register") {
				// TODO: - Handle registration logic
			}
			.font(.system(size: 30))
			.foregroundColor(Color(K.BrandColors.blue))
			.frame(height: 48)
			.frame(maxWidth: .infinity)
			.background(Color(K.BrandColors.lightBlue))

			Spacer()
		}
		.frame(maxHeight: .infinity)
		.padding(.horizontal, 20)
		.background(Color("BrandLightBlue"))
		.ignoresSafeArea()
    }
}

#Preview {
    RegisterView()
}
