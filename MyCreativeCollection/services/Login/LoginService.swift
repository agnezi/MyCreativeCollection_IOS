//
// MyCreativeCollection
// Created by: itsjagnezi on 05/07/23
// Copyright (c) today and beyond
//

import Foundation
import Alamofire

final class LoginService {
	
	public static let shared = LoginService()
	
	private let headers = UserDefaultsWorker.shared.getAllTokens()
	
	private init() {}
	
	public func requestLogin(usernameOrEmail: String, password: String) async throws -> Bool {
		
		return try await withCheckedThrowingContinuation { continuation in
			let loginData = LoginRequestBody(usernameOrEmail: usernameOrEmail, password: password)
			
			CommonNetwork.shared.af.request(
				"\(CommonNetwork.shared.baseUrl)/auth/sign-in",
				method: .post,
				parameters: loginData,
				encoder: JSONParameterEncoder.default
			).validate().responseDecodable(of: LoginResponseData.self) { response in
				
				switch(response.result) {
				case let .success(data):
					continuation.resume(returning: true)
					
					UserDefaultsWorker.shared.saveAuthTokens(tokens: data)
					
				case let .failure(error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
	
	public func checkTokens() async throws -> Bool {
		return try await withCheckedThrowingContinuation { continuation in
			
			CommonNetwork.shared.af.request(
				"\(CommonNetwork.shared.baseUrl)/auth/check-auth",
				method: .get,
				headers: headers
			).responseDecodable(of: Bool.self) { response in
				switch(response.result) {
				case let .success(data):
					continuation.resume(returning: data)
					
				case let .failure(error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
}
