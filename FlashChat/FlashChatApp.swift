//
//  FlashChatApp.swift
//  FlashChat
//
//  Created by Arthur Norat on 08/10/25.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin

@main
struct FlashChatApp: App {
	@Environment(\.scenePhase) var scenePhase

	var body: some Scene {
		WindowGroup {
			NavigationStack {
				WelcomeView()
			}
		}
		.onChange(of: scenePhase) { _, phase in
			if phase == .background {
				Task {
					try? await Amplify.Auth.signOut()
				}
			}
		}
	}
	
	init() {
		configureAmplify()
	}
	
	func configureAmplify() {
		do {
			try Amplify.add(plugin: AWSCognitoAuthPlugin())
			try Amplify.configure(with: .amplifyOutputs)
			print("Amplify configured with auth plugin")
		} catch {
			print("Failed to initialize Amplify with \(error)")
		}
	}
}
