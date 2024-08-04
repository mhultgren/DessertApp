//
//  DessertApp.swift
//  Dessert
//
//  Created by Hultgren, Myles on 8/2/24.
//

import SwiftUI

@main
struct DessertApp: App {
	var body: some Scene {
        WindowGroup {
            DessertList(viewModel: DessertListViewModel())
        }
    }
}
