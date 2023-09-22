//
// MyCreativeCollection
// Created by: itsjagnezi on 31/08/23
// Copyright (c) today and beyond
//

import Foundation
import Alamofire

final class SignUpService {
	public static let shared = SignUpService()
	
	private let headers = UserDefaultsWorker.shared.getAllTokens()
	
	private init() {}
	
	public func requestCreateAccount(userData: SignUpBody) async throws -> Bool {
		
		return try await withCheckedThrowingContinuation { continuation in
			CommonNetwork.shared.af.request(
				"\(CommonNetwork.shared.baseUrl)/auth/sign-up",
				method: .post,
				parameters: userData,
				encoder: JSONParameterEncoder.default
			).validate().responseDecodable(of: SignUpResponse.self) {
				response in
				
				switch(response.result) {
				case .success(_):
					continuation.resume(returning: true)
					
				case let .failure(error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
}
