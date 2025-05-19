//
//  SearchViewModel.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 18/05/2025.
//

import Foundation
import Combine
import Factory

class SearchViewModel: ObservableObject {
    
    @Injected(\.recipiesUseCase) private var recipiesUseCase
    @Injected(\.favoritesUseCase) private var favoritesUseCase
    
    @Published var searchText: String = ""
    @Published var searchRecipesLoadingState: LoadingState<[Recipie]> = .loading
    
    @Published var searchRecipes: [Recipie]? = nil
    @Published var isSearchRecipesLoading: Bool = true
    
    @Published var searchRecipesOffset: Int = 0
    @Published var isFetchingMoreRecipies: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        subscribeToSearchRecipesLoadingState()
        subscribeToSearchValue()
    }
}

// MARK: - Listen For Subscribers

extension SearchViewModel {
    func subscribeToSearchRecipesLoadingState() {
        $searchRecipesLoadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                    case .loading:
                        self.isSearchRecipesLoading = true
                        self.searchRecipes = Recipie.mockArray(count: 10)
                    case .loaded(let data):
                        self.isSearchRecipesLoading = false
                        self.searchRecipes = data
                    case .error:
                        self.isSearchRecipesLoading = false
                        self.searchRecipes = nil
                    default:
                        break
                }
            }
            .store(in: &cancellables)
    }
    
    func subscribeToSearchValue() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] value in
                guard let self = self else { return }
                
                if value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.searchRecipes = nil
                    self.searchRecipesOffset = 0
                    self.searchRecipesLoadingState = .idle
                    return
                }
                
                self.fetchRecipesBasedOnSearch()
            }
            .store(in: &cancellables)
    }
    
}

// MARK: - API Calls

extension SearchViewModel {
    func fetchRecipesBasedOnSearch(isPaginating: Bool = false) {
        guard !isFetchingMoreRecipies else { return }
        if !isPaginating {
            searchRecipesLoadingState = .loading
        }
        isFetchingMoreRecipies = true
        let request = RecipiesRequest(
            from: isPaginating ? searchRecipesOffset : 0,
            size: 10,
            q: searchText
        )
        
        recipiesUseCase.exectute(recipiesRequest: request) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let recipiesResponse):
                        if isPaginating {
                            self.searchRecipes?.append(contentsOf: recipiesResponse.results)
                        } else {
                            self.searchRecipes = recipiesResponse.results
                        }
                        self.searchRecipesLoadingState = .loaded(self.searchRecipes ?? [])
                        self.searchRecipesOffset += recipiesResponse.results.count
                    case .failure(let error):
                        print("Failed: \(error)")
                        if !isPaginating {
                            self.searchRecipesLoadingState = .error
                        }
                }
                self.isFetchingMoreRecipies = false
            }
        }
    }
}

// MARK: - Add to favorites

extension SearchViewModel {
    func toggleFavorite(recipe: Recipie) {
        favoritesUseCase.toggleFavorite(recipe: recipe)
    }

    func isFavorite(recipe: Recipie) -> Bool {
        favoritesUseCase.isFavorite(recipe: recipe)
    }
}
