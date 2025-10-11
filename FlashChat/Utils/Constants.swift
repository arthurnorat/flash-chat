//
//  Constants.swift
//  FlashChat
//
//  Created by Arthur Norat on 11/10/25.
//

import Foundation

struct K {

	static let appName = "⚡️FlashChat"
	static let cellIdentifier = "ReusableCell"
	static let cellNibName = "MessageCell"
	static let leftImageView = "YouAvatar"
	static let rightImageView = "MeAvatar"

	struct BrandColors {
		static let purple = "BrandPurple"
		static let lightPurple = "BrandLightPurple"
		static let blue = "BrandBlue"
		static let lightBlue = "BrandLightBlue"
	}

	struct FStore {
		static let collectionName = "messages"
		static let senderField = "sender"
		static let bodyField = "body"
		static let dateField = "date"
	}
}
