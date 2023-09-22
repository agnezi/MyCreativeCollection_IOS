//
// MyCreativeCollection
// Created by: itsjagnezi on 05/07/23
// Copyright (c) today and beyond
//

import Foundation


struct SignUpBody: Encodable {
	let email: String
	let name: String
	let username: String
	let password: String
}


struct SignUpResponse: Codable {
	let name: String
	let username: String
	let id: UUID
	let creatdAt: String
	let email: String
}
