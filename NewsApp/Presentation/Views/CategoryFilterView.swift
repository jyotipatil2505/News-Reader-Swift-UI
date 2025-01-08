//
//  CategoryFilterView.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import SwiftUI

/// The CategoryFilterView is a SwiftUI view component that allows users to filter news articles by category.
struct CategoryFilterView: View {
    @ObservedObject var viewModelWrapper: NewsListViewModelWrapper

    var body: some View {
        
        /// A ScrollView with a horizontal axis is used to allow the user to scroll through the categories.
        ScrollView(.horizontal, showsIndicators: false) {
            
            /// A HStack is used to layout the category items in a horizontal row. Each category is displayed as a Text view representing the category's name (category.rawValue).
            HStack(spacing: 16) {
                ForEach(NewsCategory.allCases) { category in
                    Text(category.rawValue)
                        .padding()
                        .background(viewModelWrapper.viewModel.selectedCategory == category ? Color.blue : Color.gray)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .onTapGesture {
                            viewModelWrapper.viewModel.selectedCategory = category
                            viewModelWrapper.viewModel.fetchNews() 
                        }
                }
            }
            .accessibilityIdentifier(AccessibilityIdentifier.categoryFilterView)
            .padding()
        }
    }
}
