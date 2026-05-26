//
//  ContentView.swift
//  FlashChat
//
//  Created by Arthur Norat on 08/10/25.
//

import SwiftUI

struct WelcomeView: View {

	@StateObject private var viewModel = WelcomeViewModel()
	@State private var navigateToRegister = false
	@State private var navigateToLogin = false

	var body: some View {
		VStack {

			Spacer()

			HStack {
				Image(systemName: "bolt.fill")
					  .font(.system(size: 40))
					  .foregroundColor(Color(K.BrandColors.blue))
				Text(viewModel.titleText)
					.font(.system(size: 50, weight: .black))
					.foregroundColor(Color(K.BrandColors.blue))
			}
			Spacer()

			Button("Register") {
				navigateToRegister = true
			}
			.font(.system(size: 30))
			.foregroundColor(Color(K.BrandColors.blue))
			.frame(height: 48)
			.frame(maxWidth: .infinity)
			.background(Color(K.BrandColors.lightBlue))

			Button("Log In") {
				navigateToLogin = true
			}
			.font(.system(size: 30))
			.foregroundColor(.white)
			.frame(height: 48)
			.frame(maxWidth: .infinity)
			.background(Color.teal)
			.clipShape(Rectangle())
		}
		.padding(.horizontal, 0)
		.onAppear {
			viewModel.animateTitle()
		}
		.navigationDestination(isPresented: $navigateToRegister) {
			RegisterView(onLogOut: { navigateToRegister = false })
		}
		.navigationDestination(isPresented: $navigateToLogin) {
			LoginView(onLogOut: { navigateToLogin = false })
		}
	}
}

#Preview {
	WelcomeView()
}
