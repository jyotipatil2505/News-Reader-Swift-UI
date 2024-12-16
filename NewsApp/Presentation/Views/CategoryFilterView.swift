//
//  CategoryFilterView.swift
//  NewsApp
//
//  Created by Jyoti Patil on 23/10/24.
//

import SwiftUI

struct CategoryFilterView: View {
    @ObservedObject var viewModel: NewsViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(NewsCategory.allCases) { category in
                    Text(category.rawValue)
                        .padding()
                        .background(viewModel.selectedCategory == category ? Color.blue : Color.gray)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .onTapGesture {
                            viewModel.selectedCategory = category
                            viewModel.fetchNews() 
                        }
                }
            }
            .accessibilityIdentifier(AccessibilityIdentifier.categoryFilterView)
            .padding()
        }
    }
}
