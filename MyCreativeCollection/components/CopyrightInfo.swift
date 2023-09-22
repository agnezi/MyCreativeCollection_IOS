////
// MyCreativeCollection
// Created by: itsjagnezi on 16/09/23
// Copyright (c) today and beyond
//

import SwiftUI

struct CopyrightInfo: View {
	var body: some View {
		Group {
			Text("loginScreen.acceptTermsAgreeing") +
			Text("loginScreen.termsOfUse")
				.bold()
				.underline() +
			Text(" ") +
			Text("common.and") +
			Text(" ") +
			Text("loginScreen.privacyPolicy")
				.bold()
				.underline()
		}
		.font(.caption)
		.padding(.top, 16)
	}
}

struct CopyrightInfo_Previews: PreviewProvider {
	static var previews: some View {
		CopyrightInfo()
	}
}
