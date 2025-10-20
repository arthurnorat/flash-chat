//
//  ContentView.swift
//  FlashChat
//
//  Created by Arthur Norat on 08/10/25.
//

import SwiftUI

struct WelcomeView: View {
	
	@StateObject private var viewModel = WelcomeViewModel()
	
    var body: some View {
		VStack {
			
			Spacer()
			
            Text(viewModel.titleText) // Title animation
				.font(.system(size: 50, weight: .black))
				.foregroundColor(Color(K.BrandColors.blue))
			
			Spacer()
			
			// Register button
			NavigationLink(destination: RegisterView()) {
				Text("Register")
					.font(.system(size: 30))
					.foregroundColor(Color(K.BrandColors.blue))
					.frame(height: 48)
					.frame(maxWidth: .infinity)
					.background(Color(K.BrandColors.lightBlue))
			}
			
			// Login button
			NavigationLink(destination: LoginView()) {
				Text("Log In")
					.font(.system(size: 30))
					.foregroundColor(.white)
					.frame(height: 48)
					.frame(maxWidth: .infinity)
					.background(Color.teal)
					.clipShape(Rectangle())
			}
        }
		.padding(.horizontal, 0)
		.onAppear {
			viewModel.animateTitle()
		}
    }
}

#Preview {
    WelcomeView()
}
