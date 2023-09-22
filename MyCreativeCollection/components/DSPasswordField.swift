//
// MyCreativeCollection
// Created by: itsjagnezi on 05/09/23
// Copyright (c) today and beyond
//

import SwiftUI

struct DSPasswordField: View {
	
	let placeholder: LocalizedStringKey
	@FocusState.Binding var focusedField: FocusedField?
	let focusWhen: FocusedField
	@Binding var password: String
  
	var body: some View {
			SecureField(
				placeholder,
				text: $password
			)
				.textFieldDefaultStyle()
				.focused($focusedField, equals: focusWhen)
    }
}

struct DSPasswordField_Previews: PreviewProvider {
	@FocusState static var focus: FocusedField?
	
    static var previews: some View {
			DSPasswordField(
				placeholder: "common.password",
				focusedField: $focus,
				focusWhen: .password,
				password: .constant("test")
			)
    }
}
