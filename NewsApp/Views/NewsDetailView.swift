//
//  NewsDetailView.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import SwiftUI
struct NewsDetailView: View {
    let article: Article
    @Environment(\.presentationMode) var presentationMode // Access to the current presentation mode

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Display article image if available
                if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill) // Change to fill to cover the space
                            .frame(maxWidth: .infinity) // Set to fill available width
                            .clipped() // Clipping to ensure it doesn't overflow
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView() // Show a loading indicator while the image is loading
                    }
                    .frame(height: 200) // Set a fixed height for the image
                    .padding(.horizontal)
                    .padding(.top, 16) // Add top padding to prevent overlapping with the navigation bar
                }
                
                // Article title
                Text(article.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.top, .horizontal])
                
                // Article description
                if let description = article.description {
                    Text(description)
                        .font(.body)
                        .padding(.horizontal)
                }
                
                // Read more link
                Link("Read more", destination: URL(string: article.url)!)
                    .padding()
                    .foregroundColor(.blue)
                
                Spacer() // Adds space below the content
            }
        }
        .navigationTitle("Article")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left") // Custom back button image
                }
            }
        }
    }
}
