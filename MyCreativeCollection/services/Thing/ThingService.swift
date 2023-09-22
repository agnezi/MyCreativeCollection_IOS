//
// MyCreativeCollection
// Created by: itsjagnezi on 01/08/23
// Copyright (c) today and beyond
//

import Foundation
import Alamofire

final class ThingService {
	
	public static let shared = ThingService()
	
	private let headers = UserDefaultsWorker.shared.getAllTokens()
	
	private init() {}
	
	public func createThing(thing: ThingCreateBody) async throws {
		return try await withCheckedThrowingContinuation { continuation in
			print("posting-create-thing-for-collectionId-\(thing.collectionId)")
			CommonNetwork.shared.af.request(
				"\(CommonNetwork.shared.baseUrl)/things/create",
				method: .post,
				parameters: thing,
				encoder: JSONParameterEncoder.default,
				headers: headers
			).validate().responseDecodable(of: ThingResponseData.self) {
				response in
				
				switch(response.result) {
				case .success(_):
					print("thing-created")
					
					continuation.resume()
					
				case let .failure(error):
					print(error.localizedDescription)
					
					continuation.resume(throwing: error)
				}
			}
		}
	}
	
	public func getThings(_ collectionId: String) async throws -> [ThingResponseData] {
		
		return try await withCheckedThrowingContinuation { continuation in
			print("get-things-for-collectionId-\(collectionId)")
			CommonNetwork.shared.af.request(
				"\(CommonNetwork.shared.baseUrl)/things/\(collectionId)",
				method: .get,
				headers: headers
			).validate().responseDecodable(of: [ThingResponseData].self) { response in
				
				switch(response.result) {
				case let .success(data):
					print("things-list-response")
	
					continuation.resume(returning: data)
					
				case let .failure(error):
					print(error.localizedDescription)
					
					continuation.resume(throwing: error)
				}
			}
		}
	}
	
	public func deleteThing(id: UUID) async throws {
		return try await withCheckedThrowingContinuation { continuation in
			print("deleting-thing")
			CommonNetwork.shared.af.request(
				"\(CommonNetwork.shared.baseUrl)/things/\(id.uuidString.lowercased())",
				method: .delete,
				headers: headers
			).validate().response {
				response in
				
				switch(response.result) {
				case .success(_):
					print("thing-deleted")
					
					continuation.resume()
					
				case let .failure(error):
					print(error.localizedDescription)
					
					continuation.resume(throwing: error)
				}
			}
		}
	}
}
