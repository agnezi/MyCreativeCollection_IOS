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
	@EnvironmentObject var viewModel: ViewModel
	
	var body: some View {
		Form {
			Section(Intl.CreateCollectionScreenIntlEn.sectionTitle) {
				TextField(Intl.CreateCollectionScreenIntlEn.titleTextField, text: $title)
				
				Button(Intl.CreateCollectionScreenIntlEn.createButtonLabel) {
					let new = Collection(title: title)
					viewModel.addColectionOnListAndSaveCollectionOnFile(new)
					
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
