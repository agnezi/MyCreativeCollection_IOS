////
// MyCreativeCollection
// Created by: itsjagnezi on 16/09/23
// Copyright (c) today and beyond
//

import SwiftUI

struct SocialMediaSignInButtons: View {
	var geo: GeometryProxy
	
	var body: some View {
		//			 MARK: Divisor with or text
		VStack(alignment: .center) {
			HStack {
				Rectangle()
					.fill(.thinMaterial)
					.frame(minWidth: geo.frame(in: .local).width / 2 - 55, maxHeight: 2)
				Spacer()
				Text("common.or")
					.bold()
				Spacer()
				Rectangle().fill(.thinMaterial)
					.frame(minWidth: geo.frame(in: .local).width / 2 - 55, maxHeight: 2)
			}
			
			// MARK: Enterprises login button
			HStack {
				//MARK: Apple
				ZStack{
					Rectangle()
						.cornerRadius(8)
					
					Image(systemName: "applelogo")
						.foregroundColor(.white)
				}
				.frame(minWidth: geo.frame(in: .local).width / 3 - 16, maxHeight: 55)
				
				//MARK: Facebook
				Rectangle()
					.foregroundColor(.facebook)
					.frame(minWidth: geo.frame(in: .local).width / 3 - 16, maxHeight: 55)
					.cornerRadius(8)
				
				//MARK: Google
				Rectangle()
					.foregroundColor(.google)
					.frame(minWidth: geo.frame(in: .local).width / 3 - 16, maxHeight: 55)
					.cornerRadius(8)
			}
		}
	}
}

struct SocialMediaSignInButtons_Previews: PreviewProvider {
	static var previews: some View {
		GeometryReader {geo in
			SocialMediaSignInButtons(geo: geo)
		}
	}
}
