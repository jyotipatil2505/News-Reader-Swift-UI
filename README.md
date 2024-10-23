# NewsReader App

The **NewsReader App** is a SwiftUI-based mobile application designed to provide users with access to the latest news articles across various categories. Users can browse articles, read full content, bookmark their favorite articles, and filter news by categories, all within a clean and intuitive interface.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [API Integration](#api-integration)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)
- [Contact](#contact)

## Overview

The NewsReader app aims to simplify how users consume news by aggregating articles from multiple sources and presenting them in an easy-to-navigate format. The application includes essential features such as bookmarking articles for offline reading and filtering news by category to enhance user experience.

## Features

- **Browse Latest News**: Access a wide range of articles organized by categories like Business, Technology, Sports, Health, and more.
- **Read Full Articles**: Tap on any article to view its complete content.
- **Bookmark Articles**: Easily bookmark articles for later reading.
- **Category Filtering**: Filter news by categories to find articles that match your interests.
- **User-Friendly Interface**: Enjoy a clean, intuitive design for an optimal reading experience.
- **Offline Access**: Save articles for reading later, even without an internet connection.

## Screenshots

### Home Screen
![Home Screen](path/to/home-screen.png)

### Article Detail View
![Article Detail](path/to/article-detail.png)

### Bookmarked Articles
![Bookmarked Articles](path/to/bookmarked-articles.png)

## Installation

To set up the NewsReader App on your local machine, follow these steps:

### Prerequisites

- Ensure you have the latest version of Xcode installed.
- Clone the repository to your local machine.

### Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/jyotipatil2505/News-Reader-Swift-UI.git

2. Navigate into the project directory:

   ```bash
   cd NewsApp

3. Open the Xcode project:

   ```bash
   open NewsApp.xcodeproj

4. Run the app on a simulator or a physical device by pressing Cmd + R.


## API Integration

The NewsReader app utilizes the [NewsAPI](https://newsapi.org/) to fetch articles. This integration allows the app to display real-time news updates across various categories.

### Getting Started with NewsAPI

1. **Sign Up for an API Key**: 
   - Visit [NewsAPI.org](https://newsapi.org/) and create an account to obtain your API key. This key is essential for making requests to the API.

2. **Add Your API Key**: 
   - Once you have your API key, open the `APIConfig.swift` file in your project.
   - Replace the placeholder API key with your actual key:

   ```swift
   static let apiKey: String = "YOUR_API_KEY"

### Example API Request

The NewsReader app makes use of the `NewsRepository` class to handle requests to the NewsAPI. Below is an example of how to fetch the top headlines and handle the response.

      ```swift
      let endpoint = category == .all || category == nil ? Endpoint.topHeadlines() : Endpoint.topHeadlines(category: category?.rawValue)
     APIManager.shared.request(endpoint: endpoint) { (result: Result<NewsResponse, NetworkError>) in
         switch result {
         case .success(let newsResponse):
             completion(.success(newsResponse.articles))
         case .failure(let error):
             print("error :::::: ",error)
             completion(.failure(error))
         }
      }


### Fetching Articles by Category

To enhance user experience, the NewsReader app allows you to fetch articles filtered by specific categories. You can specify a category when calling the `fetchNews` method in the `NewsService`. Below is an example of how to request articles related to a specific category, such as Business:

   ```swift
   newsService.fetchNews(category: .business) { result in
       switch result {
       case .success(let articles):
           // Handle the successful response
           print("Fetched Business articles: \(articles)")
           // You can now update your UI or store the articles as needed
       case .failure(let error):
           // Handle any errors that occur during the request
           print("Error fetching Business articles: \(error.localizedDescription)")
       }
   }
