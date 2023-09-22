//
// MyCreativeCollection
// Created by: itsjagnezi on 25/05/23
// Copyright (c) today and beyond
//

import SwiftUI

struct LoginScreen: View {
	@FocusState private var focusedField: FocusedField?
	@EnvironmentObject private var navigationViewModel: NavigationModel
	
	@State private var usernameOrEmail = "test123"
	@State private var password = "test123"
	@State private var isSecured = true
	
	
	var body: some View {
		GeometryReader { geo in
			VStack(alignment: .leading) {
				
				VStack(alignment: .leading) {
					Text("loginScreen.welcome")
						.font(Font.custom("JetBrainsMonoNL-Regular", size: 32, relativeTo: .title))
					Text("common.appName")
						.font(Font.custom("JetBrainsMonoNL-Regular", size: 32, relativeTo: .title))
				}
				.font(.largeTitle)
				.bold()
				
				VStack(alignment: .leading, spacing: 16) {
					//MARK: UsernameOrEmail Field
					DSTextField(
						placeholder: "loginScreen.usernameOrEmail",
						focusedField: $focusedField,
						focusWhen: .usernameOrEmail,
						text:  $usernameOrEmail)
					
					//MARK: Password Fields
					HStack {
						if isSecured {
							DSPasswordField(
								placeholder: "common.password",
								focusedField: $focusedField,
								focusWhen: .passwordInvisible,
								password: $password
							)
						} else {
							DSTextField(
								placeholder: "common.password",
								focusedField: $focusedField,
								focusWhen: .passwordVisible,
								text: $usernameOrEmail)
						}
						
						//MARK: Toggle password visibility
						Button(action: {
							isSecured.toggle()
						}, label: {
							Image(systemName: self.isSecured ? "eye.slash" : "eye")
								.accentColor(.gray)
						})
					}
					
					//MARK: Forgot password link
					NavigationLink("Forgot Password") {
						ForgotPasswordScreen()
					}
				}
				.padding(.vertical, 4)
				
				
				// MARK: Divisor with or text
//				SocialMediaSignInButtons(geo: geo)
				
				Spacer()
				
				VStack {
					Group {
						//MARK: Login button
						DSButton(label: "common.continue", action: loginButtonPresss)
						
						//MARK: Create Account Button
						DSNavigationLink(label: "Sign Up", value: .signUpScreen)
					}
					.cornerRadius(8)
					
					//MARK: Right text
					CopyrightInfo()
				}
			}
			.padding([.horizontal], 16)
			.background(Color.powderBlue)
//			.onAppear {
//				Task {
//					let isAuthenticated = try await LoginService.shared.checkTokens()
//					
//					if isAuthenticated {
//						navigationViewModel.navigationTo("CollectionsScreen")
//					}
//				}
//				
//				focusedField = .usernameOrEmail
//			}
			.navigationBarHidden(true)
		}
	}
	
	func loginButtonPresss() {
		Task {
			let logged = try await LoginService.shared.requestLogin(usernameOrEmail: usernameOrEmail, password: password)
			
			if logged {
				navigationViewModel.pushView(.collectionsScreen)
			}
		}
	}
}

struct LoginScreen_Previews: PreviewProvider {
	static var previews: some View {
		LoginScreen()
	}
}
