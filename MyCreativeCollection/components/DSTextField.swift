//
// MyCreativeCollection
// Created by: itsjagnezi on 16/09/23
// Copyright (c) today and beyond
//

import SwiftUI


struct DSTextField: View {
	let placeholder: LocalizedStringKey
	@FocusState.Binding var focusedField: FocusedField?
	let focusWhen: FocusedField
	@Binding var text: String
	
	var body: some View {
		TextField(placeholder, text: $text)
			.textFieldDefaultStyle()
			.focused($focusedField, equals: focusWhen)
	}
}

struct DSTextField_Previews: PreviewProvider {
	@FocusState static var focus: FocusedField?
	static var previews: some View {
		
		DSTextField(
			placeholder: "loginScreen.usernameOrEmail",
			focusedField: $focus,
			focusWhen: .usernameOrEmail,
			text: .constant("test")
		)
	}
}
