//
// MyCreativeCollection
// Created by: itsjagnezi on 11/04/23
// Copyright (c) today and beyond
//

import SwiftUI


struct CreateThingScreen: View {
	let collection: Collection
	@Environment(\.dismiss) var dismiss
	@Environment(\.managedObjectContext) var moc
	@State private var title = ""
	@State private var status: ThingStatus = .have
	//	@State private var description = "Write something here"
	
	
	var body: some View {
		Form {
			Section("Add thing") {
				
				TextField("Title", text: $title)
				
				//				TextEditor(text: $description)
				//					.foregroundColor(Color.gray)
				//					.font(.custom("HelveticaNeue", size: 13))
				//					.lineSpacing(5)
				
				Picker("Status", selection: $status) {
					ForEach(ThingStatus.allCases) { thingStatus in
						Text(thingStatus.rawValue.capitalized)
					}
				}
				.pickerStyle(.segmented)
				
				Button("Add") {
					createThing()
				}
			}
		}
	}
	
	func createThing() {
		let thing = Thing(context: moc)
		thing.id = UUID()
		thing.title = title
		thing.status = status.rawValue
		thing.collection = collection
		
		try? moc.save()
		
		dismiss()
	}
}
