//
//  CategoriesViewModel.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 12/05/2025.
//

import Foundation
import Factory
import Combine

class CategoriesViewModel: Observable {
    @Injected(\.categoriesUseCase) private var categoriesUseCase
    
    @Published var categories: [Categories]? = []
    @Published var loadingState: LoadingState<[Categories]> = .loading
    @Published var isLoading: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        fetchCategories()
        listenToSubscribers()
    }
}

// MARK: - API Calls

extension CategoriesViewModel {
    func fetchCategories() {
        let request = CategoryRequest()
        categoriesUseCase.execute(categoryRequest: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.categories = response.results
                    }
                case .failure(let error):
                    print("Error \(error)")
            }
        }
        
    }
}

// MARK: - Listen to subscribers

extension CategoriesViewModel {
    private func listenToSubscribers() {
        $loadingState
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
