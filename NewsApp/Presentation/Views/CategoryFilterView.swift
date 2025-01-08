//
//  CategoryFilterView.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import SwiftUI

struct CategoryFilterView: View {
    @ObservedObject var viewModelWrapper: NewsListViewModelWrapper

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
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
