//
// MyCreativeCollection
// Created by: itsjagnezi on 11/04/23
// Copyright (c) today and beyond
//

import SwiftUI


struct CreateThingScreen: View {
	let collection: CollectionResponseData
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject var viewModel: ViewModel
	
	@State private var title = ""
	@State private var status: ThingStatus = .HAVE
	@State private var description = "Write something here"
	@State private var volume = 0
	
	
	var body: some View {
		NavigationView{
			Form {
				TextField("common.title", text: $title)
				
				TextEditor(text: $description)
					.foregroundColor(Color.gray)
					.font(.custom("HelveticaNeue", size: 13))
					.lineSpacing(5)
				
				Picker("Volume", selection: $volume) {
					ForEach(0 ..< 100) {
						Text("\($0)")
					}
				}
				.pickerStyle(.wheel)
				
				Picker("common.status", selection: $status) {
					ForEach(ThingStatus.allCases) { thingStatus in
						Text(thingStatus.rawValue.capitalized)
					}
				}
				.pickerStyle(.segmented)
				
				Button("common.add") {
					
					Task {
						viewModel.setThingsLoading(true)
						let newThing = ThingCreateBody(collectionId: collection.id.uuidString.lowercased(), title: title, description: description, volume: volume, status: status)
						
						try await ThingService.shared.createThing(thing: newThing)
						
						let things = try await ThingService.shared.getThings(collection.id.uuidString.lowercased())
						
						viewModel.setThingsData(things)
						viewModel.setThingsLoading(false)
					}
					
					dismiss()
				}
			}
			.navigationTitle("createThingScreen.addThing")
		}
	}
}

struct CreateThingScreen_Previews: PreviewProvider {
	static var previews: some View {
		CreateThingScreen(collection: CollectionResponseData.exampleList[0])
	}
}
