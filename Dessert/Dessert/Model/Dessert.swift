//
//  Dessert.swift
//  Dessert
//
//  Created by Hultgren, Myles on 8/2/24.
//

import Foundation

struct DessertResponse: Codable {
	var meals: [Dessert]
}

struct Dessert: Codable, Identifiable {
	var id: String
	var thumbnail: String
	var name: String
	
	var ingredients: [Ingredient]
	var instructions: String?
	
	struct Ingredient: Identifiable {
		var id: String { name + measurement }
		
		var name: String
		var measurement: String
	}
	
	// TODO: What is happening here exactly?
	private struct DynamicCodingKeys: CodingKey {
		var stringValue: String
		init?(stringValue: String) {
			self.stringValue = stringValue
		}

		var intValue: Int?
		init?(intValue: Int) {
			return nil
		}
	}
	
	enum CodingKeys: String, CodingKey {
		case id = "idMeal"
		case thumbnail = "strMealThumb"
		case instructions = "strInstructions"
		case name = "strMeal"
	}
	
	// TODO: Research more into custom Decodable implementation
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
		
		self.id = try container.decode(String.self, forKey: .id)
		self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
		self.name = try container.decode(String.self, forKey: .name)
		self.instructions = try? container.decode(String.self, forKey: .instructions)
		
		var tempIngredients = [Ingredient]()
		
		// while ingredient and measurements exist, parse into additional `Ingredient` objects
		var ingredientNumber = 1
		while let ingredientName = dynamicContainer.allKeys.first(where: { $0.stringValue == "strIngredient\(ingredientNumber)" }),
			  let measurementName = dynamicContainer.allKeys.first(where: { $0.stringValue == "strMeasure\(ingredientNumber)" }) {
			ingredientNumber += 1
			
			if let ingredientValue = try dynamicContainer.decodeIfPresent(String.self, forKey: ingredientName),
			   let measurementValue = try dynamicContainer.decodeIfPresent(String.self, forKey: measurementName) {
				tempIngredients.append(Ingredient(name: ingredientValue,
												  measurement: measurementValue))
			}
		}
		
		self.ingredients = tempIngredients.compactMap {
			guard !$0.name.isEmpty && !$0.measurement.isEmpty else { return nil }
			
			return $0
		}
	}
}
