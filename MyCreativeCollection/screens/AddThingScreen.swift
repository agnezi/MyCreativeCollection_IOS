//
// MyCreativeCollection
// Created by: itsjagnezi on 11/04/23
// Copyright (c) today and beyond
//

import SwiftUI


struct AddThingScreen: View {
	let collection: Collection
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject var viewModel: ViewModel
	
	@State private var title = ""
	@State private var status: ThingStatus = .have
	@State private var description = "Write something here"
	
	
	var body: some View {
		Form {
			Section("Add thing") {
				
				TextField("Title", text: $title)
				
				TextEditor(text: $description)
					.foregroundColor(Color.gray)
					.font(.custom("HelveticaNeue", size: 13))
					.lineSpacing(5)
					
				
				Picker("Status", selection: $status) {
					ForEach(ThingStatus.allCases) { thingStatus in
						Text(thingStatus.rawValue.capitalized)
					}
				}
				.pickerStyle(.segmented)
				
				Button("Add") {
					
					let new = Thing(title: title, description: description, status: status)
					
					viewModel.addThingOnListAndSaveThingOnFile(newThing: new, collection: collection)
					
					dismiss()
				}
			}
		}
	}
}

struct AddThingScreen_Previews: PreviewProvider {
	static var previews: some View {
		AddThingScreen(collection: Collection.exampleList[0])
	}
}
