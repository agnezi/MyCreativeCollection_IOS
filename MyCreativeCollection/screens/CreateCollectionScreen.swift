//
// MyCreativeCollection
// Created by: itsjagnezi on 11/04/23
// Copyright (c) today and beyond
//

import SwiftUI


struct CreateCollectionScreen: View {
	
	@State private var title = ""
	@State private var description = "createCollectionScreen.collectionDescription"
	@EnvironmentObject var viewModel: ViewModel
	@Environment(\.dismiss) var dismiss
	
	var body: some View {
		Group {
			Form {
				Section("createCollectionScreen.title") {
					TextField("common.title", text: $title)
					
					TextEditor(text: $description)
						.font(.caption)
					
					Button("common.create") {
						let newCollection = CollectionCreateBody(title: title, description: description)
						
						Task {
							viewModel.setCollectionsLoading(true)
							try await CollectionService.shared.createCollection(collection: newCollection)
							let collections = try await CollectionService.shared.getAllCollections()
							viewModel.setCollectionsData(collections)
							viewModel.setCollectionsLoading(false)
							dismiss()
						}
					}
				}
			}
		}
		if viewModel.collectionsLoading {
			VStack(alignment: .center) {
				ProgressView {
					Text("Creating collection")
				}
				.progressViewStyle(.circular)
			}
		}
	}
}


struct CreateCollectionScreen_Previews: PreviewProvider {
	static var previews: some View {
		CreateCollectionScreen()
	}
}
