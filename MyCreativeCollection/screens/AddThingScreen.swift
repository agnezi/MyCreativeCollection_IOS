//
// MyCreativeCollection
// Created by: itsjagnezi on 11/04/23
// Copyright (c) today and beyond
//

import SwiftUI


struct AddThingScreen: View {
	@Environment(\.dismiss) var dismiss
	
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
				print("Add thing to collection")
					
					dismiss()
				}
			}
		}
	}
}
