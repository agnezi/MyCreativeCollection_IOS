////
// MyCreativeCollection
// Created by: itsjagnezi on 25/05/23
// Copyright (c) today and beyond
//

import SwiftUI

struct LoginScreen: View {
	
	@State private var username = ""
	@State private var password = ""
	
	@State private var isSecured = true
	
	var body: some View {
		GeometryReader { geo in
			VStack(alignment: .leading) {
				
				VStack(alignment: .leading) {
					Button(action: {}, label: {
						Image(systemName: "xmark")
							.font(.title)
							.foregroundColor(.black)
					})
					.padding(.bottom, 24)
					
					Text("Welcome to ")
					Text("RandomCompany®")
					
				}
				.font(.largeTitle)
				.bold()
				
				
				VStack(alignment: .center) {
					VStack(spacing: 16) {
						TextField("Username", text: $username)
							.padding(8)
							.font(.title2)
							.autocapitalization(.none)
							.disableAutocorrection(true)
							.background(.thinMaterial)
							.cornerRadius(8)
						
						HStack {
							if isSecured {
								
								SecureField("Password", text: $password)
									.padding(8)
									.font(.title2)
									.autocapitalization(.none)
									.disableAutocorrection(true)
									.keyboardType(.asciiCapable)
									.background(.thinMaterial)
									.cornerRadius(8)
								
							} else {
								TextField("Password", text: $password)
									.padding(8)
									.font(.title2)
									.autocapitalization(.none)
									.disableAutocorrection(true)
									.keyboardType(.asciiCapable)
									.background(.thinMaterial)
									.cornerRadius(8)
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
				}
				
				VStack(alignment: .center) {
					HStack {
						Rectangle().fill(.thinMaterial)
							.frame(width: geo.frame(in: .local).width / 2 - 55, height: 2)
						Spacer()
						Text("or")
							.bold()
						Spacer()
						Rectangle().fill(.thinMaterial)
							.frame(width: geo.frame(in: .local).width / 2 - 55, height: 2)
					}
					
					HStack {
						Rectangle()
							.frame(width: geo.frame(in: .local).width / 3 - 16, height: 55)
							.cornerRadius(8)
						Rectangle()
							.foregroundColor(.facebook)
							.frame(width: geo.frame(in: .local).width / 3 - 16, height: 55)
							.cornerRadius(8)
						Rectangle()
							.foregroundColor(.google)
							.frame(width: geo.frame(in: .local).width / 3 - 16, height: 55)
							.cornerRadius(8)
					}
				}
				
				
				Spacer()
				
				VStack {
					
					Button(action: {}) {
						Text("Continue")
							.bold()
							.padding(12)
					}
					.frame(maxWidth: .infinity)
					.foregroundColor(.white)
					.background(.black)
					.cornerRadius(8)
					.padding(.top, 16)
					
					Group {
						Text("By signing in you accept our ") +
						Text("Terms of use")
							.bold()
							.underline() +
						Text(" and ") +
						Text("Privacy Policy")
							.bold()
							.underline()
					}
					.font(.caption)
					.padding(.top, 16)
				}
			}
			.padding([.horizontal], 16)
		}
	}
}

struct LoginScreen_Previews: PreviewProvider {
	static var previews: some View {
		LoginScreen()
	}
}
