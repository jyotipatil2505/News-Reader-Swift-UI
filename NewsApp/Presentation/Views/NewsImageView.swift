//
//  NewsImageView.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import SwiftUI

struct NewsImageView: View {
    let imageUrl: String?
    let defaultImageName: String = "defaultImage" // Your default image name in assets
    
    var body: some View {
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(10)
                case .failure(_):
                    // Show default image if there is a failure loading the image
                    Image(defaultImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(10)
                    
                case .empty:
                    // Show a placeholder (e.g., loading spinner) while loading
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                @unknown default:
                    // Handle any unknown state
                    EmptyView()
                }
            }
            .frame(height: 200)
            .padding(.horizontal)
            .padding(.top, 16)
        } else {
            // Show default image if the URL is invalid or missing
            Image(defaultImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .clipped()
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top, 16)
        }
    }
}
