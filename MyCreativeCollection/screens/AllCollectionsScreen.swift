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
	@Environment(\.managedObjectContext) var moc
	@FetchRequest(sortDescriptors: [SortDescriptor(\.title)]) var collections: FetchedResults<Collection>
	@State private var showingCreateSheet = false
	
	
	var body: some View {
		VStack {
			if collections.isEmpty {
				Text("Nothing here")
			} else {
				List {
					ForEach(collections) { collection in
						NavigationLink(destination: AllThingsScreen(collection: collection)) {
							Text(collection.title ?? "Unknow")
						}
					}
					.onDelete(perform: removeCollection)
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
	
	func removeCollection(at offsets: IndexSet) {
		for index in offsets {
			let collection = collections[index]
			
			moc.delete(collection)
		}
	}
}
