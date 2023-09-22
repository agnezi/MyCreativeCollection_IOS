//
// MyCreativeCollection
// Created by: itsjagnezi on 01/08/23
// Copyright (c) today and beyond
//

import Foundation

enum ThingStatus: String, CaseIterable, Identifiable, Codable {
	case HAVE, MISSING
	var id: Self { self }
}

struct ThingCreateBody: Codable {
	var collectionId: String
	var title: String
	var description: String
	var volume: Int
	var status: ThingStatus
}

struct ThingResponseData: Identifiable, Codable {
	var id: UUID
	var title: String
	var description: String
	var volume: Int
	var status: ThingStatus
	
	static let exampleList = [
		ThingResponseData(id: UUID(), title: "Vol 1", description: "Volume 1 do manga x", volume: 2, status: .HAVE),
		ThingResponseData(id: UUID(), title: "Vol 2", description: "Volume 2 dsdfasdgo manga x", volume: 3, status: .HAVE),
		ThingResponseData(id: UUID(), title: "Vol 3", description: "Volume 3 do sdfsadfdsa x", volume: 5, status: .HAVE),
		ThingResponseData(id: UUID(), title: "Vol 4", description: "Volume 4 do ssssss x", volume: 9, status: .MISSING),
	]
}
