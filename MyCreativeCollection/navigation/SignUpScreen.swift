//
// MyCreativeCollection
// Created by: itsjagnezi on 26/08/23
// Copyright (c) today and beyond
//

import SwiftUI

struct SignUpScreen: View {
	@FocusState private var focusedField: FocusedField?
	@EnvironmentObject private var navigationViewModel: NavigationModel
	
	@State private var name = ""
	@State private var username = ""
	@State private var email = ""
	@State private var isSecured = true
	@State private var password = ""
	@State private var confirmPassword = ""
	@State private var passwordMatch = false
	
	let signUpService = SignUpService.shared
	
	var body: some View {
		GeometryReader { geo in
			VStack(alignment: .leading) {
				
				VStack(alignment: .leading) {
					Text("common.createAccount")
						.textDefaultStyle(size: 28, relativeTo: .title)
				}
				.font(.largeTitle)
				.bold()
				
				VStack(spacing: 16) {
					//MARK: Name Field
					DSTextField(
						placeholder: "common.name",
						focusedField: $focusedField,
						focusWhen: .name,
						text: $name
					)
					
					//MARK: Username Field
					DSTextField(
						placeholder: "common.username",
						focusedField: $focusedField,
						focusWhen: .username,
						text: $username
					)

					//MARK: Email Field
					DSTextField(
						placeholder: "common.email",
						focusedField: $focusedField,
						focusWhen: .email,
						text: $email
					)
					
					//MARK: Password Fields
					HStack {
						if isSecured {
							DSPasswordField(
								placeholder: "common.password",
								focusedField: $focusedField,
								focusWhen: .passwordInvisible,
								password: $password
							)
						}
						else {
							DSTextField(
								placeholder: "common.password",
								focusedField: $focusedField,
								focusWhen: .passwordVisible,
								text: $password
							)
						}
						
						Button(action: {
							isSecured.toggle()
						}, label: {
							Image(systemName: self.isSecured ? "eye.slash" : "eye")
								.accentColor(.gray)
						})
					}
				}
				.padding(.vertical, 4)
				
				// MARK: Confirm password fields
				
				if isSecured {
					DSPasswordField(
						placeholder: "common.confirmPassword",
						focusedField: $focusedField,
						focusWhen: .confirmPassword,
						password: $confirmPassword
					)
				} else {
					DSTextField(
						placeholder: "common.confirmPassword",
						focusedField: $focusedField,
						focusWhen: .confirmPassword,
						text: $confirmPassword
					)
				}
				
				
				// MARK: Divisor with or text
//				SocialMediaSignInButtons(geo: geo)
				
				Spacer()
				
				VStack {
					Group {
						// MARK: Create account button
						DSButton(label: "common.createAccount", action: createNewUser)
			
						// MARK: Already have account button
						DSNavigationLink(label: "Login", value: .loginScreen)
					}
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
	
	private func createNewUser() {
			let newUser = SignUpBody(email: email, name: name, username: username, password: password)
			
			Task {
				let created = try await	signUpService.requestCreateAccount(userData: newUser)
				print(created)
				
				if created {
					navigationViewModel.pushView(.loginScreen)
				}
				
			}
	}
}

struct SignUpScreen_Previews: PreviewProvider {
	static var previews: some View {
		SignUpScreen()
	}
}
