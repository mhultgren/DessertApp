//
//  DessertDetailsViewModel.swift
//  Dessert
//
//  Created by Hultgren, Myles on 8/4/24.
//

import Foundation
import UIKit

/// ViewModel containing logic for dessert detail page,
/// including parsed details, and logic for fetching image (if nil) and image details
@MainActor final class DessertDetailsViewModel: ObservableObject {
	@Published var state: PageState = .loading
	@Published var dessert: Dessert
	
	var id: String { dessert.id }
	var name: String? { dessert.name }
	var image: URL? { URL(string: dessert.thumbnail) }
	var instructions: String? { dessert.instructions }
	var ingredients: [Dessert.Ingredient] { dessert.ingredients }
	
	private let serviceHandler: DessertServiceHandlerProtocol
	
	init(dessert: Dessert,
		 serviceHandler: DessertServiceHandlerProtocol = DessertServiceHandler()) {
		self.dessert = dessert
		self.serviceHandler = serviceHandler
	}
	
	// fetch details for given dessert ID
	// update details using response if successful
	func fetchDetails() {
		Task {
			let result = await serviceHandler.fetch(.lookup(id: id),
													responseType: DessertResponse.self)
			
			switch result {
			case let .success(response):
				guard let dessert = response.meals.first else {
					state = .error("Details unavailable")
					return
				}
				
				self.dessert = dessert
				state = .displaying
				
			case let .failure(error):
				state = .error(error.localizedDescription)
			}
		}
	}
}

extension DessertDetailsViewModel {
	convenience init(dessertCellViewModel: DessertCellViewModel,
					 serviceHandler: DessertServiceHandlerProtocol) {
		self.init(dessert: dessertCellViewModel.dessert,
				  serviceHandler: serviceHandler
		)
	}
}
