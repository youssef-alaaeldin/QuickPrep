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
    
    @Published var trendingRecipies: [Results] = []
    @Published var classicsRecipies: [Results] = []
    
    init() {
        fetchTrendingRecipies()
        fetchClassicsRecipies()
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
                    }
                case .failure(let error):
                    print("Failed: \(error)")
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
                    }
                case .failure(let error):
                    print("Failed: \(error)")
            }
        }
    }
}
