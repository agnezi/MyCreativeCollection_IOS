//
// MyCreativeCollection
// Created by: itsjagnezi on 23/07/23
// Copyright (c) today and beyond
//

import Foundation

final class ViewModel: ObservableObject {
	@Published private(set) var collections: [CollectionResponseData] = []
	@Published private(set) var collectionsLoading = false
	
	@Published private(set) var things: [ThingResponseData] = []
	@Published private(set) var thingsLoading = false
	
	public func setCollectionsData(_ data: [CollectionResponseData]) {
		collections = data
	}
	
	public func setCollectionsLoading(_ data: Bool) {
		collectionsLoading = data
	}
	
	public func setThingsData(_ data: [ThingResponseData]) {
		things = data
	}
	
	public func setThingsLoading(_ data: Bool) {
		thingsLoading = data
	}
}
