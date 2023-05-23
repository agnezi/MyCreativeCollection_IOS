//
// MyCreativeCollection
// Created by: itsjagnezi on 11/04/23
// Copyright (c) today and beyond
//

import QuickLook
import SwiftUI


extension Intl {
	struct ContentViewScreenIntlPtBR {
		static let emptyDescription = "Pressione o ícone no canto superior para criar uma coleção"
		static let sectionTitle = "Minhas coisas"
		static let exportButtonLabel = "Exportar meus dados"
		static let screenTitle = "Coleções"
	}
	
	struct ContentViewScreenIntlEn {
		static let emptyDescription = "Tap 'plus' button on top corner to create a collection"
		
		static let sectionTitle = "My stuffs"
		static let screenTitle = "Collections"
	}
}


struct AllCollectionsScreen: View {
	
	@State private var showingCreateSheet = false
	@EnvironmentObject var viewModel: ViewModel
	
	@State private var fileUrl: URL?
	
	var body: some View {
		Group {
			if viewModel.collections.isEmpty {
				NothingHere(description: Intl.ContentViewScreenIntlEn.emptyDescription)
			} else {
				VStack {
					List {
						Section(Intl.ContentViewScreenIntlEn.sectionTitle) {
							ForEach(viewModel.collections.indices, id: \.self) { index in
								NavigationLink(destination: CollectionScreen(collection: viewModel.collections[index])) {
									Text(viewModel.collections[index].title)
								}
								.swipeActions(edge: .trailing) {
									Button(role: .destructive) {
										viewModel.pruneCollectionAndSaveOnFile(at: index, collection: viewModel.collections[index])
									} label: {
										Label(Intl.deleteText, systemImage: "trash")
									}
								}
							}
						}
					}
					Button(Intl.exportDataText) {
						fileUrl = viewModel.getFileURL(fileName: "collections")
					}.quickLookPreview($fileUrl)
				}
			}
		}
		.navigationTitle(Intl.ContentViewScreenIntlEn.screenTitle)
		.toolbar {
			Button {
				showingCreateSheet = true
			} label: {
				Image(systemName: "plus")
			}
		}
		.sheet(isPresented: $showingCreateSheet) {
			CreateCollectionScreen()
		}
	}
}

struct AllCollectionsScreen_Previews: PreviewProvider {
	static var previews: some View {
		AllCollectionsScreen()
			.environmentObject(MockedViewModel())
	}
}
