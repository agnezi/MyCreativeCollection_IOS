////
// MyCreativeCollection
// Created by: itsjagnezi on 19/09/23
// Copyright (c) today and beyond
//

import SwiftUI

struct Navigator<Content: View>: View {
	let content: (NavigationModel) -> Content
	@StateObject var navigationViewModel = NavigationModel()
	
	var body: some View {
		NavigationStack(path: $navigationViewModel.routes) {
			content(navigationViewModel)
		}
		.environmentObject(navigationViewModel)
	}
}

