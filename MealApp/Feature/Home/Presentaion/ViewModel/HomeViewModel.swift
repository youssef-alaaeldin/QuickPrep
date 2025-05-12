//
//  HomeViewModel.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 06/05/2025.
//

import Foundation
import Combine
import Factory


class HomeViewModel: ObservableObject {
    @Injected(\.recipiesUseCase) private var recipiesUseCase
    @Injected(\.categoriesUseCase) private var categoriesUseCase
    
    @Published var categoriesLoadingState: LoadingState<[Categories]> = .loading
    @Published var trendingRecipiesLoadingState: LoadingState<[Results]> = .loading
    @Published var classicsRecipiesLoadingState: LoadingState<[Results]> = .loading
    @Published var categoryRecipiesLoadingState: LoadingState<[Results]> = .loading

    @Published var categories: [Categories]? = nil
    @Published var selectedCategory: Categories? = nil
    @Published var trendingRecipies: [Results]? = nil
    @Published var classicsRecipies: [Results]? = nil
    @Published var categoryRecipies: [Results]? = nil
    @Published var isLoading: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchTrendingRecipies()
        fetchClassicsRecipies()
        fetchBasedOnCategory()
        fetchCategories()
        subscribeToTrendingRecipiesLoadingState()
    }
}

// MARK: - Listen To Publishers
extension HomeViewModel {
    func subscribeToTrendingRecipiesLoadingState() {
        $trendingRecipiesLoadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loading:
                    self.isLoading = true
                    self.trendingRecipies = Results.mockArray(count: 10)
                case .loaded(let data):
                    self.isLoading = false
                    self.trendingRecipies = data
                case .error:
                    self.isLoading = false
                    self.trendingRecipies = nil
                default:
                    break
                }
            }
            .store(in: &cancellables)
        
        $classicsRecipiesLoadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loading:
                    self.isLoading = true
                    self.classicsRecipies = Results.mockArray(count: 10)
                case .loaded(let data):
                    self.isLoading = false
                    self.classicsRecipies = data
                case .error:
                    self.isLoading = false
                    self.classicsRecipies = nil
                default:
                    break
                }
            }
            .store(in: &cancellables)
        
        $categoryRecipiesLoadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loading:
                    self.isLoading = true
                    self.categoryRecipies = Results.mockArray(count: 10)
                case .loaded(let data):
                    self.isLoading = false
                    self.categoryRecipies = data
                case .error:
                    self.isLoading = false
                    self.categoryRecipies = nil
                default:
                    break
                }
            }
            .store(in: &cancellables)
        
        $categoriesLoadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loading:
                    self.isLoading = true
                    self.categories = Categories.mockArray(count: 10)
                case .loaded(let data):
                    self.isLoading = false
                    self.categories = data
                case .error:
                    self.isLoading = false
                    self.categories = nil
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
}

// MARK: - API Calls

extension HomeViewModel {
    func fetchTrendingRecipies() {
        let request = RecipiesRequest(size: 10)
        recipiesUseCase.exectute(recipiesRequest: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let recipiesResponse):
                    DispatchQueue.main.async {
                        self.trendingRecipies = recipiesResponse.results
                        self.trendingRecipiesLoadingState = .loaded(recipiesResponse.results)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        print("Failed: \(error)")
                        self.trendingRecipiesLoadingState = .error
                    }
            }
        }
    }
    
    func fetchClassicsRecipies() {
        let request = RecipiesRequest(size: 10, q: "classics")
        recipiesUseCase.exectute(recipiesRequest: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let recipiesResponse):
                    DispatchQueue.main.async {
                        self.classicsRecipies = recipiesResponse.results
                        self.classicsRecipiesLoadingState = .loaded(recipiesResponse.results)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        print("Failed: \(error)")
                        self.classicsRecipiesLoadingState = .error
                    }
            }
        }
    }
    
    func fetchBasedOnCategory() {
        let request = RecipiesRequest(size: 10, q: selectedCategory?.name ?? "")
        recipiesUseCase.exectute(recipiesRequest: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let recipiesResponse):
                    DispatchQueue.main.async {
                        self.categoryRecipies = recipiesResponse.results
                        self.categoryRecipiesLoadingState = .loaded(recipiesResponse.results)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        print("Failed: \(error)")
                        self.categoryRecipiesLoadingState = .error
                    }
            }
        }
    }
    
    func fetchCategories() {
        let request = CategoryRequest()
        categoriesUseCase.execute(categoryRequest: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.categories = response.results
                        self.categoriesLoadingState = .loaded(response.results)
                    }
                case .failure(let error):
                    print("Error \(error)")
                    DispatchQueue.main.async {
                        self.categoriesLoadingState = .error
                    }
            }
        }
        
    }
}
