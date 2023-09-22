//
// MyCreativeCollection
// Created by: itsjagnezi on 05/07/23
// Copyright (c) today and beyond
//

import Foundation
import Alamofire

final class UserDefaultsWorker {
	
	static let shared = UserDefaultsWorker()
	
	private static let ACCESS_TOKEN = "access_token"
	private static let REFRESH_TOKEN = "refresh_token"
	private static let USER_TOKEN = "user_token"
	
	func saveAuthTokens(tokens: LoginResponseData) {
		let defaults = UserDefaults.standard
		defaults.set(tokens.access_token, forKey: UserDefaultsWorker.ACCESS_TOKEN)
		defaults.set(tokens.refresh_token, forKey: UserDefaultsWorker.REFRESH_TOKEN)
		defaults.set(tokens.user_token, forKey: UserDefaultsWorker.USER_TOKEN)
	}
	
	func getAllTokens() -> HTTPHeaders {
		return [
			"Authorization": "Bearer \(UserDefaultsWorker.shared.getAccessToken())",
			"x-user-token": "\(UserDefaultsWorker.shared.getUserToken())",
			"x-refresh-token": "\(UserDefaultsWorker.shared.getRefreshToken())",
		]
	}
	
	func getAccessToken() -> String {
		let defaults = UserDefaults.standard
		let token = defaults.object(forKey: UserDefaultsWorker.ACCESS_TOKEN) as? String ?? ""
		return token
	}
	
	func getRefreshToken() -> String {
		let defaults = UserDefaults.standard
		let token = defaults.object(forKey: UserDefaultsWorker.REFRESH_TOKEN) as? String ?? ""
		return token
	}
	
	func getUserToken() -> String {
		let defaults = UserDefaults.standard
		let token = defaults.object(forKey: UserDefaultsWorker.USER_TOKEN) as? String ?? ""
		return token
	}
	
	func haveAuthTokens() -> Bool {
		return !getAccessToken().isEmpty && !getRefreshToken().isEmpty && !getRefreshToken().isEmpty
	}
	
	func dropTokens() {
		let defaults = UserDefaults.standard
		
		defaults.set("", forKey: UserDefaultsWorker.ACCESS_TOKEN)
		defaults.set("", forKey: UserDefaultsWorker.REFRESH_TOKEN)
		defaults.set("", forKey: UserDefaultsWorker.USER_TOKEN)
	}
	
}
