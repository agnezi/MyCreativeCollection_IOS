////
// MyCreativeCollection
// Created by: itsjagnezi on 16/09/23
// Copyright (c) today and beyond
//

import SwiftUI

struct TextDefaultStyle: ViewModifier {
	var size: CGFloat
	var relativeTo: Font.TextStyle
	
	func body(content: Content) -> some View {
		content
			.font(Font.custom("JetBrainsMonoNL-Regular", size: size, relativeTo: relativeTo))
	}
}


extension Text {
	func textDefaultStyle(size: CGFloat, relativeTo: Font.TextStyle) -> some View {
		modifier(TextDefaultStyle(size: size, relativeTo: relativeTo))
	}
}
