//
// MyCreativeCollection
// Created by: itsjagnezi on 26/07/23
// Copyright (c) today and beyond
//

import Foundation
import Alamofire

final class CommonNetwork {
	public static let shared = CommonNetwork()
	
	public let baseUrl = ProcessInfo.processInfo.environment["API_URL"]!
	
	public var af = Session(configuration: URLSessionConfiguration.default)
	
	private init() {}

}
