//
//  ClassicsRecipesViewModel.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 18/05/2025.
//

import Foundation
import Combine
import Factory

class ClassicsRecipesViewModel: ObservableObject {
    @Injected(\.recipiesUseCase) private var recipiesUseCase
    @Injected(\.favoritesUseCase) private var favoritesUseCase

    @Published var classicsRecipiesLoadingState: LoadingState<[Recipie]> = .loading
    
    @Published var classicsRecipies: [Recipie]? = nil
    @Published var isClassicsRecipiesLoading: Bool = true
    
    @Published var classicsRecipiesOffset: Int = 0
    @Published var isFetchingMoreRecipies: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        subscribeToClassicsRecipiesLoadingState()
        fetchClassicsRecipies()
    }
}

// MARK: - Listen To Subscribers

extension ClassicsRecipesViewModel {
    func subscribeToClassicsRecipiesLoadingState() {
        $classicsRecipiesLoadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                    case .loading:
                        self.isClassicsRecipiesLoading = true
                        self.classicsRecipies = Recipie.mockArray(count: 10)
                    case .loaded(let data):
                        self.isClassicsRecipiesLoading = false
                        self.classicsRecipies = data
                    case .error:
                        self.isClassicsRecipiesLoading = false
                        self.classicsRecipies = nil
                    default:
                        break
                }
            }
            .store(in: &cancellables)
        
    }
}

// MARK: - API Calls

extension ClassicsRecipesViewModel {
    func fetchClassicsRecipies(isPaginating: Bool = false) {
        guard !isFetchingMoreRecipies else { return }
        
        isFetchingMoreRecipies = true
        let request = RecipiesRequest(
            from: isPaginating ? classicsRecipiesOffset : 0,
            size: 10,
            q: "classics"
        )
        
        recipiesUseCase.exectute(recipiesRequest: request) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let recipiesResponse):
                        if isPaginating {
                            self.classicsRecipies?.append(contentsOf: recipiesResponse.results)
                        } else {
                            self.classicsRecipies = recipiesResponse.results
                        }
                        self.classicsRecipiesLoadingState = .loaded(self.classicsRecipies ?? [])
                        self.classicsRecipiesOffset += recipiesResponse.results.count
                    case .failure(let error):
                        print("Failed: \(error)")
                        if !isPaginating {
                            self.classicsRecipiesLoadingState = .error
                        }
                }
                self.isFetchingMoreRecipies = false
            }
        }
    }
}

// MARK: - Add to favorites

extension ClassicsRecipesViewModel {
    func toggleFavorite(recipe: Recipie) {
        favoritesUseCase.toggleFavorite(recipe: recipe)
    }

    func isFavorite(recipe: Recipie) -> Bool {
        favoritesUseCase.isFavorite(recipe: recipe)
    }
}
