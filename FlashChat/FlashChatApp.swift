//
//  FlashChatApp.swift
//  FlashChat
//
//  Created by Arthur Norat on 08/10/25.
//

import SwiftUI
import Amplify
import AmplifyPlugins

@main
struct FlashChatApp: App {
	var body: some Scene {
		WindowGroup {
			NavigationStack {
				WelcomeView()
			}
		}
	}
	
	init() {
		configureAmplify()
	}
	
	func configureAmplify() {
		do {
			try Amplify.add(plugin: AWSCognitoAuthPlugin())
			try Amplify.configure()
			print("Amplify configured with auth plugin")
		} catch {
			print("Failed to initialize Amplify with \(error)")
		}
	}
}
