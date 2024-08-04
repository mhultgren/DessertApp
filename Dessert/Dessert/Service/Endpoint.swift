//
//  Endpoint.swift
//  Dessert
//
//  Created by Hultgren, Myles on 8/4/24.
//

import Foundation

struct API {
	static let base = "https://themealdb.com/api/json/v1/1/"
}

enum DessertEndpoint {
	case list
	case lookup(id: String)
	
	var path: String {
		switch self {
		case .list:
			return "filter.php"
		case .lookup:
			return "lookup.php"
		}
	}
	
	var parameters: [String : String] {
		switch self {
		case .list:
			return ["c": "Dessert"]
		case let .lookup(id):
			return ["i": id]
		}
	}
}
