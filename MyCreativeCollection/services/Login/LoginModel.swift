//
// MyCreativeCollection
// Created by: itsjagnezi on 05/07/23
// Copyright (c) today and beyond
//

import Foundation

struct LoginRequestBody: Encodable {
	let usernameOrEmail: String
	let password: String
}


struct LoginResponseData: Decodable {
	let access_token: String
	let user_token: String
	let refresh_token: String
}
