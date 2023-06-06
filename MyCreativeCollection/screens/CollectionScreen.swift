////
// MyCreativeCollection
// Created by: itsjagnezi on 11/04/23
// Copyright (c) today and beyond
//

import SwiftUI

extension Intl {
	struct CollectionScreenIntlEn {
		static let emptyDescription = "Tap 'plus' button on top corner to add a thing"
	}
}



struct CollectionScreen: View {
	
	@State private var showingAddThing = false
	@State private var fileUrl: URL?
	@FetchRequest(sortDescriptors: []) var things: FetchedResults<Thing>
	
	var body: some View {
		VStack {
			if things.isEmpty {
				Text("Nothing")
						 } else {
					List {
						ForEach(things.indices, id: \.self) { index in
							VStack(alignment: .leading) {
								Text(things[index].title ?? "Empty")
									.font(.headline)
									.foregroundColor(things[index].status == ThingStatus.missing.rawValue ? Color.red : Color.primary)
								
								Text(things[index].description)
									.font(.caption)
									.foregroundColor(.secondary)
							}
							.swipeActions(edge: .trailing) {
								Button(role: .destructive) {
									print("Remove thing")
								} label: {
									Label(Intl.deleteText, systemImage: "trash")
								}
							}
						}
					}
				}
						 }
					.navigationTitle("Collection.title")
					.toolbar {
						Button {
							showingAddThing = true
						} label: {
							Image(systemName: "plus")
						}
					}
					.sheet(isPresented: $showingAddThing) {
						AddThingScreen()
					}
						 }
						 }
