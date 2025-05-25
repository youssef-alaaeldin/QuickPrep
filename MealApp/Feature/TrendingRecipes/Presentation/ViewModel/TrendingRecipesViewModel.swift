//
//  TrendingRecipesViewModel.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 18/05/2025.
//

import Foundation
import Factory
import Combine

class TrendingRecipesViewModel: ObservableObject {
    @Injected(\.recipiesUseCase) private var recipiesUseCase

    @Published var trendingRecipiesLoadingState: LoadingState<[Recipie]> = .loading
    
    @Published var trendingRecipies: [Recipie]? = nil
    @Published var isTrendingRecipiesLoading: Bool = true
    
    @Published var trendingRecipiesOffset: Int = 0
    @Published var isFetchingMoreRecipies: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        subscribeToTrendingRecipiesLoadingState()
        fetchTrendingRecipies()
    }
}

// MARK: - Listen To Subscribers

extension TrendingRecipesViewModel {
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
extension TrendingRecipesViewModel {
    func fetchTrendingRecipies(isPaginating: Bool = false) {
        guard !isFetchingMoreRecipies else { return }
        
        isFetchingMoreRecipies = true
        let request = RecipiesRequest(
            from: isPaginating ? trendingRecipiesOffset : 10,
            size: 10
        )
        
        recipiesUseCase.exectute(recipiesRequest: request) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let recipiesResponse):
                        if isPaginating {
                            self.trendingRecipies?.append(contentsOf: recipiesResponse.results)
                        } else {
                            self.trendingRecipies = recipiesResponse.results
                        }
                        self.trendingRecipiesLoadingState = .loaded(self.trendingRecipies ?? [])
                        self.trendingRecipiesOffset += recipiesResponse.results.count
                    case .failure(let error):
                        print("Failed: \(error)")
                        if !isPaginating {
                            self.trendingRecipiesLoadingState = .error
                        }
                }
                self.isFetchingMoreRecipies = false
            }
        }
    }
}
