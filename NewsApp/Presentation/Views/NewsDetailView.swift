//
//  NewsDetailView.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import SwiftUI

/// The NewsDetailView is a SwiftUI view used to display the detailed content of a single news article.
struct NewsDetailView: View {
    
    /// This is the article data that will be displayed in the view.
    let article: ArticleModel
    @Environment(\.presentationMode) var presentationMode // Access to the current presentation mode
    
    var body: some View {
        
        /// The main body of the view is wrapped in a ScrollView to ensure that the content is scrollable if it exceeds the available screen space.
        ScrollView {
            VStack(alignment: .leading) {
                
                /// Display article image if available
                NewsImageView(imageUrl: article.urlToImage)
                
                /// Article title
                Text(article.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.top, .horizontal])
                
                /// Article description
                if let description = article.description {
                    Text(description)
                        .font(.body)
                        .padding(.horizontal)
                }
                
                /// Read more link
                Link("Read more", destination: URL(string: article.url)!)
                    .padding()
                    .foregroundColor(.blue)
                    .accessibilityIdentifier(AccessibilityIdentifier.readMoreLink)
                
                /// Adds space below the content
                Spacer()
            }
        }
        .navigationTitle("Article Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .accessibilityIdentifier(AccessibilityIdentifier.newsDetailsView)
        .toolbar {
            
            /// A custom back button is placed in the navigation bar using a ToolbarItem.
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
