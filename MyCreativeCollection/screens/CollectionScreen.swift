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
	@EnvironmentObject var viewModel: ViewModel
	@State private var fileUrl: URL?
	
	var collection: Collection
	
	var body: some View {
		Group {
			if viewModel.things.isEmpty {
				NothingHere(description: Intl.CollectionScreenIntlEn.emptyDescription)
			} else {
				VStack {
					List {
						ForEach(viewModel.things.indices, id: \.self) { index in
							VStack(alignment: .leading) {
								Text(viewModel.things[index].title)
									.font(.headline)
									.foregroundColor(viewModel.things[index].status == .missing ? Color.red : Color.primary)
								
								Text(viewModel.things[index].description)
									.font(.caption)
									.foregroundColor(.secondary)
							}
							.swipeActions(edge: .trailing) {
								Button(role: .destructive) {
									viewModel.removeThingFromListAndSaveOnFile(at: index, collection: collection)
								} label: {
									Label(Intl.deleteText, systemImage: "trash")
								}
							}
						}
					}
					Button(Intl.exportDataText) {
						fileUrl = viewModel.getFileURL(fileName: collection.fileName)
					}.quickLookPreview($fileUrl)
				}
			}
		}
		.onAppear {
			Task {
				if let data = try viewModel.loadFile(collection.fileName) {
					let nativeData = try viewModel.parseToData(jsonData: data, type: [Thing].self)
					
					viewModel.setThingsOnList(from: nativeData)
				}
			}
		}
		.onDisappear {
			viewModel.resetThingsList()
		}
		.navigationTitle(collection.title)
		.toolbar {
			Button {
				showingAddThing = true
			} label: {
				Image(systemName: "plus")
			}
		}
		.sheet(isPresented: $showingAddThing) {
			AddThingScreen(collection: collection)
		}
	}
}

struct CollectionScreen_Previews: PreviewProvider {
	static var previews: some View {
		CollectionScreen(collection: Collection.exampleList[0])
			.environmentObject(MockedViewModel())
	}
}
