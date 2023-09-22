////
// MyCreativeCollection
// Created by: itsjagnezi on 15/09/23
// Copyright (c) today and beyond
//

import SwiftUI

struct DSButton: View {
	
	let label: LocalizedStringKey
	let action: () -> Void
	
    var body: some View {
			Button(action: action) {
				Text(label)
					.foregroundColor(.black)
					.font(Font.custom("JetBrainsMonoNL-Bold", size: 28))
					.bold()
					.padding(12)
					.frame(maxWidth: .infinity)
			}
			.background(Color.steelBlue)
    }
}

struct DSButton_Previews: PreviewProvider {
    static var previews: some View {
			DSButton(label: "common.continue", action: {})
    }
}
