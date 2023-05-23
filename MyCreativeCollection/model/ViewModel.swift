////
// MyCreativeCollection
// Created by: itsjagnezi on 11/04/23
// Copyright (c) today and beyond
//

import Foundation


class ViewModel: ObservableObject {
	let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
	
	@Published private(set) var collections = [Collection]()
	@Published private(set) var things = [Thing]()
	
	init() {
		
		let fileName = "collections"
		
		do {
			let fileExist = checkIfCollectionsFileExists(fileName: fileName)
			
			if fileExist == false {
				collections = [Collection]()
				return
			}
			
			if let jsonData = try loadFile(fileName) {
				if let data = try parseToData(jsonData: jsonData, type: [String: [Collection]].self) {
					
					collections = data[fileName] ?? [Collection]()
				}
			}
			
		} catch {
			print("Error on viewModel class init")
			
			collections = [Collection]()
		}
	}
	
	func getFileURL(fileName: String) -> URL? {
		if let url = urls.first {
			var fileURL = url.appendingPathComponent(fileName)
			fileURL = fileURL.appendingPathExtension("json")
			return fileURL
		}
		return nil
	}
	
	func loadFile(_ fileName: String) throws -> Data? {
		if let url = urls.first {
			var fileURL = url.appendingPathComponent(fileName)
			fileURL = fileURL.appendingPathExtension("json")
			let data = try Data(contentsOf: fileURL)
			
			return data
		}
		return nil
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
	
	func addColectionOnListAndSaveCollectionOnFile(_ new: Collection) {
		
		collections.append(new)
		
		saveCollectionOnFile(dictionaryName: "collections", fileName: "collections", data: collections)
	}
	
	func setThingsOnList(from data: [Thing]?) {
		things = data ?? [Thing]()
	}
	
	func addThingOnListAndSaveThingOnFile(newThing: Thing, collection: Collection) {
		
		things.append(newThing)
		
		saveThingOnFile(fileName: collection.fileName, data: things)
	}
	
	func resetThingsList() {
		things = [Thing]()
	}
	
	func removeThingFromListAndSaveOnFile(at index: Int, collection: Collection) {
		
		things.remove(at: index)
		
		saveThingOnFile(fileName: collection.fileName, data: things)
	}
	
	func pruneCollectionAndSaveOnFile(at index: Int, collection: Collection) {
		removeAllThingsAndSaveOnFile(collection)
		collections.remove(at: index)
		saveCollectionOnFile(dictionaryName: collection.title, fileName: collection.fileName, data: collections)
	}
	
	private func removeAllThingsAndSaveOnFile(_ collection: Collection) {
		things.removeAll()
		saveThingOnFile(fileName: collection.fileName, data: things)
	}
	
	private func checkIfCollectionsFileExists(fileName: String) -> Bool {
		if let url = urls.first {
			var fileURL = url.appendingPathComponent(fileName)
			fileURL = fileURL.appendingPathExtension("json")
			 
			let fileExists = try? fileURL.checkResourceIsReachable()
			
			if fileExists != nil && fileExists != false {
				return true
			}
			
			return false
		}
		return false
	}
	
	private func saveFile(_ fileName: String, jsonData: Data) throws -> Bool {
		do {
			if let url = urls.first {
				var fileURL = url.appendingPathComponent(fileName)
				fileURL = fileURL.appendingPathExtension("json")
				
				print(jsonData)
				
				try jsonData.write(to: fileURL, options: [.atomic])
				return true
			}
			return false
			
		} catch {
			print(error)
			
			return false
		}
	}
	
	private func parseToJson<T: Encodable>(data: T) throws -> Data? {
		do {
			
			let encoder = JSONEncoder()
			
			let json = try encoder.encode(data)
			
			return json
			
		} catch {
			print("Error trying to parse data to json")
			return nil
		}
	}
	
	private func saveCollectionOnFile<T: Encodable>(dictionaryName: String, fileName: String, data: T) {
		do {
			if let jsonData = try parseToJson(data: [dictionaryName: data]) {
				try saveFile(fileName, jsonData: jsonData)
			}
			
		} catch {
			print("Error on trying to save on private save func")
		}
	}
	
	private func saveThingOnFile<T: Encodable>(fileName: String, data: T) {
		do {
			if let jsonData = try parseToJson(data: data) {
				try saveFile(fileName, jsonData: jsonData)
			}
			
		} catch {
			print("Error on trying to save on private save func")
		}
	}
}
