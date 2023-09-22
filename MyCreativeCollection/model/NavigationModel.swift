//
// MyCreativeCollection
// Created by: itsjagnezi on 11/04/23
// Copyright (c) today and beyond
//

import Foundation
import SwiftUI

protocol NavigationManagerDelegate {
	associatedtype Route = NavigationPaths
	func pushView(_ newView: Route)
	func popToRoot()
	func pop()
	func popUntil(_ targetScreen: Route)
}


enum NavigationPaths: CaseIterable {
	case loginScreen
	case signUpScreen
	case forgotPasswordScreen
	case collectionsScreen
	//	case collectionScreen
}

enum Routes {
	static let routes: [NavigationPaths: AnyView] = [
		.loginScreen: AnyView(LoginScreen()),
		.signUpScreen: AnyView(SignUpScreen()),
		.forgotPasswordScreen: AnyView(ForgotPasswordScreen()),
		.collectionsScreen: AnyView(CollectionsScreen())
//		.collectionScreen: AnyView(CollectionScreen()),
	]
	
	static func routerReturner(path: NavigationPaths) -> some View {
		let index = Routes.routes.index(forKey: path)!
		return Routes.routes[index].value
	}
}

final class NavigationModel: ObservableObject, NavigationManagerDelegate {
	
	@Published var routes: [NavigationPaths] = []
	
	func pushView(_ newView: NavigationPaths) {
		routes.append(newView)
	}
	
	func popToRoot() {
		self.routes.removeAll()
	}
	
	func pop() {
		self.routes.removeAll()
	}
	
	func popUntil(_ targetRoute: NavigationPaths) {
		if self.routes.last != targetRoute {
			self.routes.removeLast()
			popUntil(targetRoute)
		}
	}
}
