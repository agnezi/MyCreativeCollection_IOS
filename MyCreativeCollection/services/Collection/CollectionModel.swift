//
// MyCreativeCollection
// Created by: itsjagnezi on 19/07/23
// Copyright (c) today and beyond
//

import Foundation

struct CollectionCreateBody: Codable, Hashable {
	var title: String
	var description: String
}


struct CollectionResponseData: Identifiable, Codable, Hashable {
	var id: UUID
	var title: String
	var description: String
	
	static let exampleList = [
		CollectionResponseData(id: UUID(), title: "Old boy", description: "bla bla bla"),
		CollectionResponseData(id: UUID(), title: "Naruto", description: "bla bla bla"),
		CollectionResponseData(id: UUID(), title: "Demon Slayer", description: "bla bla bla"),
		CollectionResponseData(id: UUID(), title: "Boruto", description: "bla bla bla"),
		CollectionResponseData(id: UUID(), title: "Dragonball Z", description: "bla bla bla"),
		CollectionResponseData(id: UUID(), title: "Dragonball Super", description: "bla bla bla"),
		CollectionResponseData(id: UUID(), title: "Cavaleiro dos zodiacos", description: "bla bla bla"),
	]
}
