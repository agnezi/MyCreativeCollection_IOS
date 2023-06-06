//
// MyCreativeCollection
// Created by: itsjagnezi on 11/04/23
// Copyright (c) today and beyond
//

import SwiftUI

struct CollectionCard: View {
	var body: some View {
		ZStack(alignment: .topTrailing) {
			ZStack(alignment: .bottom) {
				Image(systemName: "books.vertical")
					.resizable()
					.cornerRadius(20)
					.frame(width: 180, height: 200)
					.scaledToFit()
				
				VStack(alignment: .leading) {
					Text("Title of Collection")
						.bold()
					
					Text("Some description about the collection")
						.font(.caption)
				}
				.padding()
				.frame(width: 180, alignment: .leading)
				.background(.ultraThinMaterial)
				.cornerRadius(20)
			}
			NavigationLink(destination: CollectionScreen()) {
				Image(systemName: "plus")
					.padding(10)
					.foregroundColor(.white)
					.background(.ultraThinMaterial)
					.cornerRadius(50)
					.padding()
			}
		}
	}
}

struct CollectionCard_Previews: PreviewProvider {
	static var previews: some View {
		CollectionCard()
	}
}
