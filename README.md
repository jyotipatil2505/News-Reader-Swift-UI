# NewsReader App

The **NewsReader App** is a SwiftUI-based mobile application designed to provide users with access to the latest news articles across various categories. Users can browse articles, read full content, bookmark their favorite articles, and filter news by categories, all within a clean and intuitive interface.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
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

#### Home Screen
<img src="https://github.com/jyotipatil2505/News-Reader-Swift-UI/blob/main/NewsApp/Screenshots/TopHeadlines.png" alt="Home Screen" width="240" />

#### Article Detail Screen
<img src="https://github.com/jyotipatil2505/News-Reader-Swift-UI/blob/main/NewsApp/Screenshots/ArticleDetails.png" alt="Article Detail Screen" width="240" />

#### Bookmarked Articles Screen
<img src="https://github.com/jyotipatil2505/News-Reader-Swift-UI/blob/main/NewsApp/Screenshots/Bookmarks.png" alt="Bookmarked Screen" width="240" />


## Architecture

This project follows the **MVVM** (Model-View-ViewModel) architecture pattern, which helps keep the code modular, maintainable, and testable.

- **Model**: Represents the app data, such as `Article`. It defines the structure of the data and how it can be encoded/decoded.
  
- **View**: SwiftUI views that display the data and handle user interactions. These are responsible for rendering the user interface and responding to user input.
  
- **ViewModel**: Contains the business logic, communicates with the service layer, and provides data to the View. It acts as an intermediary between the Model and the View, managing the state and behavior of the UI.


## Folder Structure

- 
  ```bash
  
  NewsApp/
  |
  ├── Screenshots/
  │   ├── Bookmarks.png                          # Displays the main screen of the CryptoCoin app, showing a list of available cryptocurrency coins.
  │   ├── TopHeadlines.png                                    # Demonstrates the filter functionality within the app
  │   └── ArticleDetails.png                        # Illustrates the detailed view of the searched list of cryptocurrency coins
  ├── Application/                                          # Core presentation layer of the application, handling UI logic and user interaction.
  │   ├── SceneDelegate.swift                                        # Contains logic to manage the UI data.
  ├── Presentation/                                          # Core presentation layer of the application, handling UI logic and user interaction.
  │   ├── Utils                                        # Contains logic to manage the UI data.
  │   │   ├── AccessibilityIdentifier.swift                     # Manages the logic for fetching and preparing crypto coin data for display in the UI.
  │   ├── ViewModels                                        # Contains logic to manage the UI data.
  │   │   ├── NewsViewModel.swift                     # Manages the logic for fetching and preparing crypto coin data for display in the UI.
  │   │   ├── ViewModelFactory.swift                     # Manages the logic for fetching and preparing crypto coin data for display in the UI.
  │   ├── Views                                             # Displays list of articles
  │   │   ├── NewsListView.swift                              # UI component to apply multiple filters to the crypto coin list.
  │   │   ├── MainView.swift                              # Displays a loading animation while data is being fetched.
  │   │   ├── BookmarkView.swift                     # Custom table cell to display coin details (name, symbol, type) with appropriate styles.
  │   │   ├── NewsDetailView.swift                              # Displays a placeholder when there is no data to show.
  │   │   ├── CategoryFilterView.swift.swift                              # Displays a placeholder when there is no data to show.
  │   │   ├── NewsImageView.swift.swift.swift                              # Displays a placeholder when there is no data to show.
  ├── Domain/                                               # Contains business logic, which is independent of frameworks and UI.
  │   ├── UseCases                                          # Encapsulates specific business logic.
  │   │   ├── FetchNewsUseCase.swift                   # Handles the use case of fetching a list of crypto coins from data sources.
  │   ├── Repositories                                      # Defines interfaces for data operations.
  │   │   ├── NewsRepositoryProtocol.swift               # Outlines the methods for interacting with crypto coin data sources (local or network).
  │   ├── Entities                                          # Represents core application models.
  │   │   ├── NewsCategory.swift                         # Data model defining the structure of a crypto coin entity.
  │   │   ├── NewsResponse.swift                         # Data model defining the structure of a crypto coin entity.
  │   │   ├── ArticleModel.swift                         # Data model defining the structure of a crypto coin entity.
  ├── Data/                                                 
  │   ├── DataSources                                       
  │   │   ├── Local                                         # Handles local storage of crypto coin data.
  │   │   │   ├── Mappers                                   # Converts data between local and domain models.
  │   │   │   │   ├── ArticleModel+RealmMapper.swift     # Maps between CryptoCoinModel and Realm model.
  │   │   │   │   ├── ArticleRealm+DomainMapper.swift    # Maps between Realm model and domain model.
  │   │   │   ├── Models                                    # Contains Realm database models for storing crypto coin data.
  │   │   │   │   │── ArticleRealm.swift                 # Protocol for network service operations.
  │   │   │   ├── NewsLocalDataSource.swift           # Implementation of local data operations.
  │   │   │   ├── NewsLocalDataSourceImpl.swift                   # Defines errors related to local storage operations.
  │   │   │   ├── LocalStorageError.swift                   # Defines errors related to local storage operations.
  │   │   ├── Network                                       # Handles fetching data from remote sources.
  │   │   │   ├── NewsNetworkDataSource.swift             # Protocol for network operations.
  │   │   │   ├── NewsNetworkDataSourceImpl.swift         # Implementation of network operations.
  │   ├── Repositories                                      # Concrete implementations of data repositories.
  │   │   ├── NewsRepository.swift                        # Implements methods to fetch and manage crypto coin data from local or network sources.
  ├── Core/                                                 # Contains shared resources and utility classes.
  │   ├── Utils                                      # Concrete implementations of data repositories.
  │   │   ├── Constants.swift                        # Implements methods to fetch and manage crypto coin data from local or network sources.
  │   │   ├── Extensions.swift                        # Implements methods to fetch and manage crypto coin data from local or network sources.
  │   │   ├── Helpers.swift                       # Implements methods to fetch and manage crypto coin data from local or network sources.
  │   │   ├── Localization.swift                        # Implements methods to fetch and manage crypto coin data from local or network sources.
  │   │   ├── Reachability.swift                        # Implements methods to fetch and manage crypto coin data from local or network sources.
  ├── Infrastructure/                                       
  │   ├── Network                                           # Manages API calls and network configurations.
  │   │   ├── Protocols                                     
  │   │   │   ├── APIServiceProtocol.swift                  # Protocol for network service operations.
  │   │   │   APIConfig.swift                               # Configuration for Base Url, Api Keys.
  │   │   │   APIServiceManager.swift                              # Manages network requests and responses.
  │   │   │   Endpoints.swift                               # Defines API endpoints.
  │   │   │   HTTPMethod.swift                              # Enum for HTTP request methods (GET, POST, etc.).
  │   │   │   NetworkError.swift                            # Defines network-related errors.
  │   │   │   NetworkManager.swift                              # Implements network service operations.
  |── Resources/
  │   ├── Preview Content                                            
  │   │   ├── Preview Assets.xcassets                           # Handles localization and internationalization for the app
  │   ├── Main.storyboard                                   # Primary storyboard for the application UI.
  │   ├── Assets.xcassets                                   # Images and icons used in the app.
  ├── NewsAppUITests/
  │   ├── Presentation                                      # Includes test cases for the presentation layer of the application
  │   │   ├── NewsAppUITests.swift                # Contains unit tests for the CryptoListViewModel
  ├── NewsApp.xcworkspace                                # Xcode project
  ├── README.md     

  

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
   cd News-Reader-Swift-UI

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

The NewsReader app makes use of the `NewsRepository` class to handle requests to the NewsAPI. 

- Below is an example of how to fetch the top headlines and handle the response.:

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

   To enhance user experience, the NewsReader app allows you to fetch articles filtered by specific categories. You can specify a category when calling the `fetchNews` method in the `NewsService`. 

- Below is an example of how to request articles related to a specific category, such as Business::

   ```swift
   newsService.fetchNews(category: .business) { result in
       switch result {
       case .success(let articles):
           // Use the fetched articles
           print("Business articles: \(articles)")
       case .failure(let error):
           // Handle any errors that occur
           print("Error fetching business articles: \(error.localizedDescription)")
       }
   }
   

### Supported Categories

The NewsReader app provides users with the ability to filter articles based on various news categories. This feature helps users easily find news that aligns with their interests. Below are the supported categories:

- **All**: Displays all available articles from different sources, providing a comprehensive view of current events.
- **Business**: Articles related to business news, including market updates, financial news, and economic trends.
- **Entertainment**: Covers news from the entertainment industry, including movies, music, celebrity gossip, and events.
- **Health**: Articles focusing on health-related topics, including wellness tips, medical breakthroughs, and health news.
- **Science**: Features articles about scientific discoveries, research findings, and innovations across various fields.
- **Sports**: News related to sports events, athlete performances, and updates from the sports world.
- **Technology**: Articles about the latest trends in technology, gadget reviews, software updates, and tech industry news.

Users can select any of these categories to tailor their news feed according to their preferences, making it easier to stay informed about topics that matter to them.


## Usage

To use the NewsReader app, follow these steps:

1. **Launch the App**: 
   Open the NewsReader app on your device or simulator. You will be greeted with the home screen displaying the latest articles.

2. **View Articles**: 
   Tap on any article to read its full content. This will navigate you to a detailed view of the article where you can find additional information.

3. **Bookmark Articles**: 
   Use the bookmark feature to save articles for later reading. This allows you to easily revisit your favorite articles without having to search for them again.

4. **Filter News by Category**: 
   Use the grid-based menu to filter news articles by category. Select from various categories such as Business, Entertainment, Health, Science, Sports, Technology, or All to customize your news feed based on your interests.

## Contributing

Contributions to the NewsReader app are welcome and encouraged! To contribute to the project, please follow these steps:

1. **Fork the Repository**: 
   Click the "Fork" button at the top right of the repository page to create your own copy of the project.

2. **Clone Your Fork**: 
   Clone your forked repository to your local machine using the command:

   ```bash
   git clone https://github.com/your-username/News-Reader-Swift-UI.git

3. Create a New Branch: Navigate to the project directory and create a new branch for your feature or bug fix:

   ```bash
   git checkout -b feature/YourFeatureName

4. Make Your Changes: Implement your changes, ensuring that your code adheres to the project's coding standards. Be sure to write tests for any new features or functionality.

5. Commit Your Changes: Commit your changes with a clear and descriptive message:

   ```bash
   git commit -m "Add a new feature"

6. Push to Your Branch: Push your changes to your forked repository:

   ```bash
   git push origin feature/YourFeatureName

7. Open a Pull Request: Go to the original repository and open a pull request from your branch. Provide a detailed description of the changes you made and the reasons behind them.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. 

## Acknowledgments

We would like to acknowledge the following resources and contributors that have made this project possible:

- **NewsAPI**: Thank you to [NewsAPI](https://newsapi.org/) for providing a comprehensive and reliable source of news articles.
- **SwiftUI**: Special thanks to [SwiftUI](https://developer.apple.com/xcode/swiftui/) for the assistance in creating beautiful interfaces for this project and for providing resources that helped in developing the code.

If you find this project useful, consider giving it a star on GitHub or contributing to its development!


## Contact

For inquiries or feedback, please reach out:

- **Email**: [jyotipatil2505@gmail.com](mailto:jyotipatil2505@gmail.com)
- **GitHub**: [jyotipatil2505](https://github.com/jyotipatil2505)

Feel free to get in touch for any questions or suggestions regarding the NewsReader app!

