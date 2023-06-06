////
// MyCreativeCollection
// Created by: itsjagnezi on 11/04/23
// Copyright (c) today and beyond
//

import Foundation



enum ThingStatus: String, CaseIterable, Identifiable, Codable {
	case have, missing
	var id: Self { self }
}

