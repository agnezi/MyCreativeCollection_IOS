//
// MyCreativeCollection
// Created by: itsjagnezi on 11/04/23
// Copyright (c) today and beyond
//

import SwiftUI

struct CollectionScreen: View {
	
	@EnvironmentObject var viewModel: ViewModel
	
	@State private var showingAddThing = false
	
	var collection: CollectionResponseData
	
	var body: some View {
		Group {
			
			if viewModel.thingsLoading {
				VStack {
					ProgressView()
						.progressViewStyle(.linear)
					ProgressView()
						.progressViewStyle(.circular)
				}
			}
			
			if !viewModel.thingsLoading && viewModel.things.isEmpty {
				NothingHere(description: "collectionScreen.emptyDescription")
			}
			
			if !viewModel.thingsLoading && !viewModel.things.isEmpty {
				VStack {
					List(viewModel.things, id: \.id) { thing in
						VStack(alignment: .leading) {
							Text(thing.title)
								.font(.headline)
								.foregroundColor(thing.status == .MISSING ? Color.red : Color.primary)
							
							Text(thing.description)
								.font(.caption)
								.foregroundColor(.secondary)
						}
						.swipeActions(edge: .trailing) {
							Button(role: .destructive) {
								Task {
									try await	ThingService.shared.deleteThing(
										id: thing.id
									)
									let data = try await ThingService.shared.getThings(collection.id.uuidString.lowercased())
									viewModel.setThingsData(data)
								}
							} label: {
								Label("common.delete", systemImage: "trash")
							}
						}
					}
				}
			}
		}
		.onAppear {
			Task {
				viewModel.setThingsLoading(true)
				let things = try await ThingService.shared.getThings(collection.id.uuidString.lowercased())
				viewModel.setThingsData(things)
				viewModel.setThingsLoading(false)
			}
			
			//			Task {
			//				if let data = try viewModel.loadFile(collection.fileName) {
			//					let nativeData = try viewModel.parseToData(jsonData: data, type: [Thing].self)
			//
			//					viewModel.setThingsOnList(from: nativeData)
			//				}
			//			}
		}
		.onDisappear {
			//			viewModel.resetThingsList()
		}
		.navigationTitle(collection.title)
		.toolbar {
			ToolbarItem(placement: .bottomBar) {
				ToolbarItemButton(toggleSomething: $showingAddThing, label: "common.newThing")
			}
		}
		.sheet(isPresented: $showingAddThing) {
			CreateThingScreen(collection: collection)
		}
	}
}

struct CollectionScreen_Previews: PreviewProvider {
	static var previews: some View {
		CollectionScreen(collection: CollectionResponseData.exampleList[0])
		//			.environmentObject(MockedViewModel())
	}
}
