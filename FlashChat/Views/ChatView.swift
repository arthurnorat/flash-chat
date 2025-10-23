//
//  ChatView.swift
//  FlashChat
//
//  Created by Arthur Norat on 23/10/25.
//

import SwiftUI

struct ChatView: View {
	var body: some View {
		Text("ChatView")
			.font(.largeTitle)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(Color("BrandLightPurple"))
			.ignoresSafeArea()
	}
}

#Preview {
	ChatView()
}
