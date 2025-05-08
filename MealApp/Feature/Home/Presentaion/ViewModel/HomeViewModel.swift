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
    
    @Published var trendingRecipiesLoadingState: LoadingState<[Results]> = .loading
    @Published var classicsRecipiesLoadingState: LoadingState<[Results]> = .loading

    @Published var trendingRecipies: [Results]? = nil
    @Published var classicsRecipies: [Results]? = nil
    @Published var isLoading: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchTrendingRecipies()
        fetchClassicsRecipies()
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
                    print("Failed: \(error)")
                    self.trendingRecipiesLoadingState = .error
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
                    print("Failed: \(error)")
                    self.classicsRecipiesLoadingState = .error
            }
        }
    }
}
