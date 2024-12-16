//
//  ViewModelFactory.swift
//  NewsApp
//
//  Created by Jyoti Patil on 11/12/24.
//
import Foundation

protocol ViewModelFactoryProtocol {
    func createCryptoListViewModel() -> NewsViewModel
}

class ViewModelFactory: ViewModelFactoryProtocol {
    func createCryptoListViewModel() -> NewsViewModel {
        let apiService = APIServiceManager() // Assuming it's already implemented
        let networkDataSource = NewsNetworkDataSourceImpl(apiService: apiService)
        let localDataSource = NewsLocalDataSourceImpl()
        let repository = NewsRepository(networkDataSource: networkDataSource, localDataSource: localDataSource)
        let useCase = FetchNewsUseCase(repository: repository)
        return NewsViewModel(newsUseCase: useCase)
    }
}
