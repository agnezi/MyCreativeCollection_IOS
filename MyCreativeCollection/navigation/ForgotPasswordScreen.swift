//
// MyCreativeCollection
// Created by: itsjagnezi on 30/08/23
// Copyright (c) today and beyond
//

import SwiftUI

struct ForgotPasswordScreen: View {
	@FocusState private var focusedField: FocusedField?
	@EnvironmentObject private var navigationViewModel: NavigationModel
	
	@State private var password = ""
	@State private var confirmPassword = ""
	@State private var passwordMatch = false
	
	var body: some View {
		VStack(alignment: .leading) {
			
			VStack(alignment: .leading) {
				Text("common.recoveryPassword")
					.textDefaultStyle(size: 28, relativeTo: .title)
			}
			.font(.largeTitle)
			.bold()
			
			VStack(spacing: 16) {
				
				//MARK: Password Field
				DSPasswordField(
					placeholder: "common.password",
					focusedField: $focusedField,
					focusWhen: .password,
					password: $password
				)
				
				//MARK: Confirm password field
				DSPasswordField(
					placeholder: "common.confirmPassword",
					focusedField: $focusedField,
					focusWhen: .confirmPassword,
					password: $confirmPassword
				)
				
				if !passwordMatch && (!password.isEmpty || !confirmPassword.isEmpty) {
					Text("Password dont match")
				}
			}
			.padding(.vertical, 4)
			
			Spacer()
			
			VStack {
				// MARK: Create account button
				DSNavigationLink(
					label: "Login",
					value: .loginScreen
				)
				.cornerRadius(8)
			}
		}
		.padding([.horizontal], 16)
		.background(Color.powderBlue)
		.navigationBarBackButtonHidden(true)
		.onChange(of: confirmPassword) { newValue in
			if newValue == password {
				passwordMatch = true
			} else {
				passwordMatch = false
			}
		}
	}
}

struct ForgotPasswordScreen_Previews: PreviewProvider {
	static var previews: some View {
		ForgotPasswordScreen()
	}
}
