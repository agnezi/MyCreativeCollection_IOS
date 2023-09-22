//
// MyCreativeCollection
// Created by: itsjagnezi on 23/07/23
// Copyright (c) today and beyond
//

import SwiftUI

struct ContentView: View {
	@StateObject var dataViewModel = ViewModel()
	
	var body: some View {
		Navigator { navigationViewModel in
			LoginScreen()
				.routeIterator()
		}
		.environmentObject(dataViewModel)
	}
	
	struct ContentView_Previews: PreviewProvider {
		static var previews: some View {
			ContentView()
		}
	}
}
