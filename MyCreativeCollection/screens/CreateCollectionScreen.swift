////
// MyCreativeCollection
// Created by: itsjagnezi on 11/04/23
// Copyright (c) today and beyond
//

import SwiftUI

extension Intl {
	struct CreateCollectionScreenIntlEn {
		static let sectionTitle = "Create collection"
		static let createButtonLabel = "Create"
		static let titleTextField = "Title"
	}
}


struct CreateCollectionScreen: View {
	
	@State private var title = ""
	@Environment(\.dismiss) var dismiss
	@Environment(\.managedObjectContext) var moc
	
	var body: some View {
		Form {
			Section(Intl.CreateCollectionScreenIntlEn.sectionTitle) {
				TextField(Intl.CreateCollectionScreenIntlEn.titleTextField, text: $title)
				
				Button(Intl.CreateCollectionScreenIntlEn.createButtonLabel) {
					let collection = Collection(context: moc)
					collection.id = UUID()
					collection.title = title
					
					try? moc.save()
					
					dismiss()
				}
			}
		}
	}
}

struct CreateCollectionScreen_Previews: PreviewProvider {
	static var previews: some View {
		CreateCollectionScreen()
	}
}
