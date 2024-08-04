//
//  DessertCell.swift
//  Dessert
//
//  Created by Hultgren, Myles on 8/2/24.
//

import SwiftUI

struct DessertCell: View {
	@ObservedObject var viewModel: DessertCellViewModel
	
	var body: some View {
		HStack {
			AsyncImage(url: viewModel.thumbnail) { image in
				image
					.resizable()
			} placeholder: {
				Color.clear
			}
			.frame(width: Constants.dessertCellImageSize.width,
				   height: Constants.dessertCellImageSize.height,
				   alignment: .center)
			.aspectRatio(contentMode: .fit)
			Spacer()
			Text(viewModel.name)
				.bold()
		}
	}
}
