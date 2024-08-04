//
//  DessertServiceHandler.swift
//  Dessert
//
//  Created by Hultgren, Myles on 8/2/24.
//

import Foundation

protocol DessertServiceHandlerProtocol {
	func fetch<T>(_ endpoint: DessertEndpoint, responseType: T.Type) async -> Result<T, Error> where T: Decodable
}

class DessertServiceHandler: DessertServiceHandlerProtocol {
	private let urlSession: URLSession
	
	init(urlSession: URLSession = .shared) {
		self.urlSession = urlSession
	}
	
	func fetch<T>(_ endpoint: DessertEndpoint, responseType: T.Type) async -> Result<T, Error> where T: Decodable {
		guard var urlComponents = URLComponents(string: API.base + endpoint.path) else { return .failure(DessertServiceError.invalidURL) }
		urlComponents.queryItems = endpoint.parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
		
		guard let url = urlComponents.url else { return .failure(DessertServiceError.invalidURL) }
		
		do {
			let (data, _) =  try await urlSession.data(from: url)
			let response = try JSONDecoder().decode(T.self, from: data)
			
			return .success(response)
		} catch {
			return .failure(error)
		}
	}
}

enum DessertServiceError: Error, LocalizedError {
	case invalidURL
	
	var errorDescription: String? {
		switch self {
		case .invalidURL:
			return "URL invalid"
		}
	}
}
