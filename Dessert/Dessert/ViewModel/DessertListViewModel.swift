//
//  DessertListViewModel.swift
//  Dessert
//
//  Created by Hultgren, Myles on 8/2/24.
//

import Foundation

/// ViewModel containing logic for dessert list page,
/// including parsed desserts, tap handling, and loading state.
@MainActor
final class DessertListViewModel: ObservableObject {
	private(set) var serviceHandler: DessertServiceHandlerProtocol
	
	@Published var dessertCells: [DessertCellViewModel] = []
	@Published var pageState: PageState = .loading
	
	init(serviceHandler: DessertServiceHandlerProtocol = DessertServiceHandler()) {
		self.serviceHandler = serviceHandler
	}
	
	// fetch list of desserts
	// update dessert view model list using response if successful
	func fetchList() {
		pageState = .loading
		
		Task {
			let result = await serviceHandler.fetch(.list,
													responseType: DessertResponse.self)
			
			switch result {
			case let .success(response):
				dessertCells = response.meals.map(DessertCellViewModel.init)
				pageState = .displaying
				
			case let .failure(error):
				pageState = .error(error.localizedDescription)
			}
		}
	}
}
