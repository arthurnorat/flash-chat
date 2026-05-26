//
//  WelcomeViewModel.swift
//  FlashChat
//
//  Created by Arthur Norat on 11/10/25.
//

import Foundation
import Combine

class WelcomeViewModel: ObservableObject {
	
	@Published var titleText: String = ""
	
	func animateTitle() {
		titleText = ""
		var charIndex = 0.0
		let fullTitle = K.appName
		
		for letter in fullTitle {
			Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) {_ in
				self.titleText.append(letter)
			}
			charIndex += 1
		}
	}
}
