//
//  NewsDetailView.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import SwiftUI
struct NewsDetailView: View {
    let article: ArticleModel
    @Environment(\.presentationMode) var presentationMode // Access to the current presentation mode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Display article image if available
                NewsImageView(imageUrl: article.urlToImage)
                
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
                    .accessibilityIdentifier(AccessibilityIdentifier.readMoreLink)                
                Spacer() // Adds space below the content
            }
        }
        .navigationTitle("Article Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .accessibilityIdentifier(AccessibilityIdentifier.newsDetailsView)
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
