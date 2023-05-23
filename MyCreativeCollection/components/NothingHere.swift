////
// MyCreativeCollection
// Created by: itsjagnezi on 13/04/23
// Copyright (c) today and beyond
//

import SwiftUI

struct NothingHere: View {
	
	let description: String
	
    var body: some View {
			VStack {
				
				Image(systemName: "note.text")
					.resizable()
					.frame(width: 200, height: 200)
					.padding()
					.background(.thinMaterial)
					.cornerRadius(20)
				
				Text("You have nothing here")
					.font(.title)
				
				Text(description)
					.foregroundColor(.secondary)
					.font(.caption)
			}
    }
}

struct NothingHere_Previews: PreviewProvider {
    static var previews: some View {
        NothingHere(description: "Tap 'plus' button on top corner to create a collection")
    }
}
