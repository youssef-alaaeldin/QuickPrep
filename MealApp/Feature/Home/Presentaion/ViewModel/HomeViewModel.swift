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
    @Published var trendingRecipiesLoadingState: LoadingState<[Recipie]> = .loading
    @Published var classicsRecipiesLoadingState: LoadingState<[Recipie]> = .loading
    @Published var categoryRecipiesLoadingState: LoadingState<[Recipie]> = .loading
    
    @Published var categories: [Categories]? = nil
    @Published var selectedCategory: Categories? = nil
    @Published var trendingRecipies: [Recipie]? = nil
    @Published var classicsRecipies: [Recipie]? = nil
    @Published var categoryRecipies: [Recipie]? = nil
    @Published var isTrendingRecipiesLoading: Bool = true
    @Published var isClassicRecipiesLoading: Bool = true
    @Published var isCategoriesLoading: Bool = true
    @Published var isCategoriesRecipiesLoading: Bool = true
    
    @Published var categoryRecipiesOffset: Int = 0
    @Published var isFetchingMoreCategoryRecipies: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        subscribeToTrendingRecipiesLoadingState()
        subscribeToClassicsRecipiesLoadingState()
        subscribeToAllCategoriesLoadingState()
        subscribeToAllCategoriesRecipiesLoadingState()
        
        fetchTrendingRecipies()
        fetchClassicsRecipies()
        fetchBasedOnCategory()
        fetchCategories()
    }
}

// MARK: - Listen To Publishers
extension HomeViewModel {
    func subscribeToAllCategoriesRecipiesLoadingState() {
        $categoryRecipiesLoadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                    case .loading:
                        self.isCategoriesRecipiesLoading = true
                        self.categoryRecipies = Recipie.mockArray(count: 10)
                    case .loaded(let data):
                        self.isCategoriesRecipiesLoading = false
                        self.categoryRecipies = data
                    case .error:
                        self.isCategoriesRecipiesLoading = false
                        self.categoryRecipies = nil
                    default:
                        break
                }
            }
            .store(in: &cancellables)
        
    }
    func subscribeToAllCategoriesLoadingState() {
        $categoriesLoadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                    case .loading:
                        self.isCategoriesLoading = true
                        self.categories = Categories.mockArray(count: 10)
                    case .loaded(let data):
                        self.isCategoriesLoading = false
                        self.categories = data
                    case .error:
                        self.isCategoriesLoading = false
                        self.categories = nil
                    default:
                        break
                }
            }
            .store(in: &cancellables)
    }
    func subscribeToClassicsRecipiesLoadingState() {
        $classicsRecipiesLoadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                    case .loading:
                        self.isClassicRecipiesLoading = true
                        self.classicsRecipies = Recipie.mockArray(count: 10)
                    case .loaded(let data):
                        self.isClassicRecipiesLoading = false
                        self.classicsRecipies = data
                    case .error:
                        self.isClassicRecipiesLoading = false
                        self.classicsRecipies = nil
                    default:
                        break
                }
            }
            .store(in: &cancellables)
    }
    
    func subscribeToTrendingRecipiesLoadingState() {
        $trendingRecipiesLoadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                    case .loading:
                        self.isTrendingRecipiesLoading = true
                        self.trendingRecipies = Recipie.mockArray(count: 10)
                    case .loaded(let data):
                        self.isTrendingRecipiesLoading = false
                        self.trendingRecipies = data
                    case .error:
                        self.isTrendingRecipiesLoading = false
                        self.trendingRecipies = nil
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
    
    func fetchBasedOnCategory(isPaginating: Bool = false) {
        guard !isFetchingMoreCategoryRecipies else { return } 
        
        isFetchingMoreCategoryRecipies = true
        let request = RecipiesRequest(
            from: isPaginating ? categoryRecipiesOffset : 0,
            size: 10,
            tags: selectedCategory?.name ?? "",
        )
        
        recipiesUseCase.exectute(recipiesRequest: request) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let recipiesResponse):
                        if isPaginating {
                            self.categoryRecipies?.append(contentsOf: recipiesResponse.results)
                        } else {
                            self.categoryRecipies = recipiesResponse.results
                        }
                        self.categoryRecipiesLoadingState = .loaded(self.categoryRecipies ?? [])
                        self.categoryRecipiesOffset += recipiesResponse.results.count
                    case .failure(let error):
                        print("Failed: \(error)")
                        if !isPaginating {
                            self.categoryRecipiesLoadingState = .error
                        }
                }
                self.isFetchingMoreCategoryRecipies = false
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
