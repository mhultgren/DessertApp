//
//  DessertDetails.swift
//  Dessert
//
//  Created by Hultgren, Myles on 8/2/24.
//

import SwiftUI

struct DessertDetails: View {
	@ObservedObject var viewModel: DessertDetailsViewModel
	
	var body: some View {
		ScrollView {
			viewModel.name.flatMap {
				Text($0)
					.font(.title)
					.bold()
			}
			
			AsyncImage(url: viewModel.image) { image in
				image
					.resizable()
			} placeholder: {
				Color.clear
			}
			.aspectRatio(contentMode: .fit)
			.roundedBrownBorder()
			
			VStack {
				Text("Ingredients")
					.secondaryHeading()
				
				ForEach(viewModel.ingredients) {
					ingredientAndMeasurement(ingredient: $0.name,
											 measurement: $0.measurement)
				}
			}
			.padding()
			.roundedBrownBorder()
			
			VStack {
				Text("Instructions")
					.padding(.bottom)
					.font(.title2)
					.bold()
				
				viewModel.dessert.instructions.flatMap(Text.init)
			}
			.padding()
			.roundedBrownBorder()
		}
		.padding(.horizontal)
		.scrollIndicators(.hidden)
		.pageState(viewModel.state)
		.task {
			viewModel.fetchDetails()
		}
	}
	
	private func ingredientAndMeasurement(ingredient: String,
								  measurement: String) -> some View {
		HStack {
			Text("• \(ingredient)")
				.bold()
			Spacer()
			Text(measurement)
		}
	}
}
