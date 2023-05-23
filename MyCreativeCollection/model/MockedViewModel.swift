////
// MyCreativeCollection
// Created by: itsjagnezi on 26/04/23
// Copyright (c) today and beyond
//

import Foundation


class MockedViewModel: ObservableObject {
	let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
	
	@Published private(set) var collections = Collection.exampleList
	@Published private(set) var things = Thing.exampleList
	

	func getFileURL(fileName: String) -> URL? {
		return URL(string: fileName)
	}
	
	func loadFile(_ fileName: String) throws -> Data? {
		return Data()
	}
	
	func parseToData<T: Decodable>(jsonData: Data, type: T.Type) throws -> T? {
		do {
			let decoder = JSONDecoder()
			
			let decodedData = try decoder.decode(type, from: jsonData)
			
			return decodedData
		} catch {
			print("Error trying to decode data")
			
			return nil
		}
	}
	
	func createCollection(_ new: Collection) {}
	
	func setThings(from data: [Thing]?) {}
	
	func addThing(newThing: Thing, collection: Collection) {}
	
	func resetThings() {}
	
	func removeThing(at index: Int, collection: Collection) {}
	
}
