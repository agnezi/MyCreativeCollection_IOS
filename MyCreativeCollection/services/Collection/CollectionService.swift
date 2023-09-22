//
// MyCreativeCollection
// Created by: itsjagnezi on 19/07/23
// Copyright (c) today and beyond
//

import Foundation
import Alamofire

final class CollectionService {
	
	public static let shared = CollectionService()
	
	private let headers = UserDefaultsWorker.shared.getAllTokens()
	
	private init() {}
	
	public func createCollection(collection: CollectionCreateBody) async throws {
		return try await withCheckedThrowingContinuation { continuation in
			print("posting-create-collection")
			CommonNetwork.shared.af.request(
				"\(CommonNetwork.shared.baseUrl)/collections/create",
				method: .post,
				parameters: collection,
				encoder: JSONParameterEncoder.default,
				headers: headers
			).validate().responseDecodable(of: CollectionResponseData.self) { response in
				
				switch(response.result) {
				case .success(_):
					print("collection-created")
					
					continuation.resume()
					
				case let .failure(error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
	
	public func getAllCollections() async throws -> [CollectionResponseData] {
		return try await withCheckedThrowingContinuation { continuation in
			print("fetching-all-collections")
			CommonNetwork.shared.af.request(
				"\(CommonNetwork.shared.baseUrl)/collections",
				method: .get,
				headers: headers
			).validate()
				.responseDecodable(of: [CollectionResponseData].self) { response in
					
					
					switch(response.result) {
					case let .success(data):
						print("success-response")
						continuation.resume(returning: data)
						
					case let .failure(error):
						print(error.localizedDescription)
						continuation.resume(throwing: error)
					}
				}
		}
	}
	
	public func deleteCollection(id: UUID) async throws {
		print("deleting-collection")
		return try await withCheckedThrowingContinuation { continuation in
			CommonNetwork.shared.af.request(
				"\(CommonNetwork.shared.baseUrl)/collections/\(id.uuidString.lowercased())",
				method: .delete,
				headers: headers
			).validate().response { response in
						
				switch(response.result) {
				case .success(_):
					print("collection-deleted")
					continuation.resume()
					
				case let.failure(error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
}
