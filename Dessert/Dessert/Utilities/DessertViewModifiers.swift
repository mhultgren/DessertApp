//
//  DessertViewModifiers.swift
//  Dessert
//
//  Created by Hultgren, Myles on 8/4/24.
//

import SwiftUI

extension View {
	func roundedBrownBorder() -> some View {
		modifier(RoundedBrownBorder())
	}
	
	func secondaryHeading() -> some View {
		modifier(SecondaryHeading())
	}
	
	func pageState(_ pageState: PageState) -> some View {
		modifier(PageStateModifier(pageState: pageState))
	}
}

struct RoundedBrownBorder: ViewModifier {
	func body(content: Content) -> some View {
		content
			.clipShape(
				RoundedRectangle(cornerRadius: Constants.brownBorderCornerRadius)
			)
			.overlay(
				RoundedRectangle(cornerRadius: Constants.brownBorderCornerRadius)
					.stroke(.brown, lineWidth: Constants.brownBorderLineWidth)
			)
	}
}

struct SecondaryHeading: ViewModifier {
	func body(content: Content) -> some View {
		content
			.padding(.bottom)
			.font(.title2)
			.bold()
	}
}

struct PageStateModifier: ViewModifier {
	let pageState: PageState
	
	@ViewBuilder
	func body(content: Content) -> some View {
		switch pageState {
		case .loading:
			ProgressView()
				.scaleEffect(Constants.progressViewScale)
		case let .error(string):
			VStack {
				Spacer()
				
				Image(systemName: "exclamationmark.triangle")
				Text(string)
				
				Spacer()
			}
		case .displaying:
			content
		}
	}
	
	var loadingView: some View {
		VStack {
			Spacer()
			ProgressView()
			Spacer()
		}
	}
}
