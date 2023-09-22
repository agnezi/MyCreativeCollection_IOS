//
// MyCreativeCollection
// Created by: itsjagnezi on 13/04/23
// Copyright (c) today and beyond
//

import SwiftUI

struct NothingHere: View {
	
	let description: LocalizedStringKey
	
    var body: some View {
			VStack {

				Text("You have nothing here")
					.font(.largeTitle)
					.bold()
				
				Text(description)
					.foregroundColor(.secondary)
					.font(.caption)
			}
    }
}

struct NothingHere_Previews: PreviewProvider {
    static var previews: some View {
        NothingHere(description: "collectionsScreen.emptyDescription")
    }
}
