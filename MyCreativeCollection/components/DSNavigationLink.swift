////
// MyCreativeCollection
// Created by: itsjagnezi on 15/09/23
// Copyright (c) today and beyond
//

import SwiftUI

struct DSNavigationLink: View {
	
	let label: String
	let value: NavigationPaths

    var body: some View {
			NavigationLink(label, value: value)
			.frame(maxWidth: .infinity)
			.padding(.horizontal, 12)
			.font(Font.custom("JetBrainsMonoNL-Bold", size: 28))
			.foregroundColor(.black)
			.bold()
//			.background(Color.steelBlue)
//			.cornerRadius(8)
    }
}

struct DSNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
			DSNavigationLink(label: "Test", value: .loginScreen)
    }
}
