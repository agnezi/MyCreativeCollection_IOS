//
// MyCreativeCollection
// Created by: itsjagnezi on 26/08/23
// Copyright (c) today and beyond
//

import Foundation
import SwiftUI

extension View {
		/// Applies the given transform if the given condition evaluates to `true`.
		/// - Parameters:
		///   - condition: The condition to evaluate.
		///   - transform: The transform to apply to the source `View`.
		/// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
		@ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
				if condition() {
						transform(self)
				} else {
						self
				}
		}
}


extension View {
	func routeIterator() -> some View {
		self.navigationDestination(for: NavigationPaths.self) { path in
			Routes.routerReturner(path: path)
		}
	}
}
