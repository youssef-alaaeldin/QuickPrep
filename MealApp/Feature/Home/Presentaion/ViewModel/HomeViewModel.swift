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
    
    
    init() {
        fetchRecipies()
    }
}

// MARK: - API Calls

extension HomeViewModel {
    func fetchRecipies() {
        let request = RecipiesRequest(size: 2, tags: "under_30_minutes")
        recipiesUseCase.exectute(recipiesRequest: request) { result in
            switch result {
                case .success(let recipies):
                    print(recipies.count)
                case .failure(let error):
                    print("Failed: \(error)")
            }
        }
    }
}
