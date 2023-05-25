////
// MyCreativeCollection
// Created by: itsjagnezi on 11/04/23
// Copyright (c) today and beyond
//

import SwiftUI

@main
struct MyCreativeCollectionApp: App {
	
	@StateObject var viewModel = ViewModel()
	
    var body: some Scene {
        WindowGroup {
					NavigationView {						
            LoginScreen()
					}
					.environmentObject(viewModel)
        }
    }
}
