//
//  DessertCellViewModel.swift
//  Dessert
//
//  Created by Hultgren, Myles on 8/2/24.
//

import Foundation
import UIKit

class DessertCellViewModel: ObservableObject, Identifiable {
	var name: String { dessert.name }
	var id: String { dessert.id }
	var thumbnail: URL? { URL(string: dessert.thumbnail) }
	
	private(set) var dessert: Dessert
	
	init(_ dessert: Dessert) {
		self.dessert = dessert
	}
}
