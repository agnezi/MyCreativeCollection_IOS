////
// MyCreativeCollection
// Created by: itsjagnezi on 11/04/23
// Copyright (c) today and beyond
//

import Foundation

struct Collection: Identifiable, Codable {
	var id = UUID()
	var title: String
	var fileName: String {
		return title.lowercased()
	}
	
	static let exampleList = [
		Collection(title: "Old boy"),
		Collection(title: "Naruto"),
		Collection(title: "Demon Slayer"),
		Collection(title: "Boruto"),
		Collection(title: "Dragonball Z"),
		Collection(title: "Dragonball Super"),
		Collection(title: "Cavaleiro dos zodiacos"),
	]
}

enum ThingStatus: String, CaseIterable, Identifiable, Codable {
	case have, missing
	var id: Self { self }
}

enum IntlCases: String, CaseIterable, Identifiable,Codable {
	case english, portuguese
	var id: Self { self }
}

struct Thing: Identifiable, Codable {
	var id = UUID()
	var title: String
	var description: String
	var status: ThingStatus
	
	
	static let exampleList = [
		Thing(title: "Vol 1", description: "Volume 1 do manga x", status: .have),
		Thing(title: "Vol 2", description: "Volume 2 dsdfasdgo manga x", status: .have),
		Thing(title: "Vol 3", description: "Volume 3 do sdfsadfdsa x", status: .have),
		Thing(title: "Vol 4", description: "Volume 4 do ssssss x", status: .missing),
	]
}
