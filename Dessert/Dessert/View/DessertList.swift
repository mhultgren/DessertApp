//
//  DessertList.swift
//  Dessert
//
//  Created by Hultgren, Myles on 8/2/24.
//

import SwiftUI

struct DessertList: View {
	@ObservedObject var viewModel: DessertListViewModel
	
	var body: some View {
		NavigationView {
			List {
				ForEach(viewModel.dessertCells) { dessertCell in
					NavigationLink {
						DessertDetails(
							viewModel: DessertDetailsViewModel(
								dessertCellViewModel: dessertCell,
								serviceHandler: viewModel.serviceHandler
							)
						)
					} label: {
						DessertCell(viewModel: dessertCell)
					}
					.padding()
					.roundedBrownBorder()
				}
			}
			.scrollContentBackground(.hidden)
			.navigationTitle("Dessert List")
		}
		.pageState(viewModel.pageState)
		.onAppear {
			viewModel.fetchList()
		}
	}
}

#Preview {
	DessertList(viewModel: DessertListViewModel())
}
