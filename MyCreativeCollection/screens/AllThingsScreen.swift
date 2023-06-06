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


struct AllThingsScreen: View {
	let collection: Collection
	@Environment(\.managedObjectContext) var moc
	@FetchRequest(sortDescriptors: []) var things: FetchedResults<Thing>
	@State private var showingAddThing = false
	@State private var fileUrl: URL?
	
	var body: some View {
		VStack {
			if things.isEmpty {
				Text("Nothing")
			} else {
				List {
					ForEach(things) { thing in
						VStack(alignment: .leading) {
							Text(thing.title ?? "Empty")
								.font(.headline)
								.foregroundColor(thing.status == ThingStatus.missing.rawValue ? Color.red : Color.primary)
							
//							Text(thing.description)
//								.font(.caption)
//								.foregroundColor(.secondary)
						}
					}
					.onDelete(perform: removeThing)
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
			CreateThingScreen(collection: collection)
		}
	}
	
	func removeThing(at offsets: IndexSet) {
		for index in offsets {
			let thing = things[index]
			
			moc.delete(thing)
		}
	}
}
