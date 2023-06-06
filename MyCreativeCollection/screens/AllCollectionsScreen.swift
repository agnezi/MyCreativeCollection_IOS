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
	@FetchRequest(sortDescriptors: []) var collections: FetchedResults<Collection>
	@State private var showingCreateSheet = false
	
	
	var body: some View {
		VStack {
			if collections.isEmpty {
				Text("Nothing here")
			} else {
				List {
					Section(Intl.ContentViewScreenIntlEn.sectionTitle) {
						ForEach(collections.indices, id: \.self) { index in
							NavigationLink(destination: CollectionScreen()) {
								Text(collections[index].title ?? "Unknow")
							}
							.swipeActions(edge: .trailing) {
								Button(role: .destructive) {
									print("Remove")
								} label: {
									Label(Intl.deleteText, systemImage: "trash")
								}
							}
						}
					}
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
