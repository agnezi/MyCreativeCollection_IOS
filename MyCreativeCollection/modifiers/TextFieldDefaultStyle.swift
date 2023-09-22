//
// MyCreativeCollection
// Created by: itsjagnezi on 05/09/23
// Copyright (c) today and beyond
//

import SwiftUI


struct TextFieldDefaultStyle: ViewModifier {
	func body(content: Content) -> some View {
		content
			.padding(8)
			.font(Font.custom("JetBrainsMonoNL-Regular", size: 22, relativeTo: .title2))
			.autocapitalization(.none)
			.disableAutocorrection(true)
			.background(Color.textFieldBackground)
			.overlay(
				RoundedRectangle(cornerRadius: 8)
					.stroke(.gray, lineWidth: 2)
			)
	}
}

extension View {
	func textFieldDefaultStyle() -> some View {
		modifier(TextFieldDefaultStyle())
	}
}
