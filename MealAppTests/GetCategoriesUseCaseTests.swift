//
//  GetCategoriesUseCaseTests.swift
//  MealAppTests
//
//  Created by Yousuf Abdelfattah on 24/05/2025.
//

import XCTest
import Factory
@testable import MealApp

// MARK: - GetCategoriesUseCaseTests

final class GetCategoriesUseCaseTests: XCTestCase {
    
    var useCase: GetCategoriesUseCase!
    var mockRepo: MockCategoryRepository!
    
    // MARK: - Setup / Teardown

    override func setUp() {
        super.setUp()
        mockRepo = MockCategoryRepository()
        Container.shared.categoriesRepository.register { self.mockRepo }
        useCase = GetCategoriesUseCase()
    }

    override func tearDown() {
        useCase = nil
        mockRepo = nil
        super.tearDown()
    }

    // MARK: - Success Scenario

    func testExecute_SuccessScenario() {
        // Arrange
        let expected = CategoryResponse.mock
        mockRepo.result = .success(expected)
        let request = CategoryRequest()

        let expectation = expectation(description: "Expected successful categories response")

        // Act
        useCase.execute(categoryRequest: request) { result in
            // Assert
            switch result {
            case .success(let response):
                XCTAssertEqual(response.count, expected.count)
                XCTAssertEqual(response.results?.count, expected.results?.count)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - Failure Scenario

    func testExecute_FailureScenario() {
        // Arrange
        enum MockError: Error { case fetchError }
        mockRepo.result = .failure(MockError.fetchError)
        let request = CategoryRequest()

        let expectation = expectation(description: "Expected failure callback")

        // Act
        useCase.execute(categoryRequest: request) { result in
            // Assert
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: -  Edge Case: Empty Response

    func testExecute_EmptyCategoryResponse() {
        // Arrange
        let emptyResponse = CategoryResponse(count: 0, results: [])
        mockRepo.result = .success(emptyResponse)

        let expectation = expectation(description: "Expected empty result")

        // Act
        useCase.execute(categoryRequest: CategoryRequest()) { result in
            // Assert
            switch result {
            case .success(let response):
                XCTAssertEqual(response.count, 0)
                XCTAssertEqual(response.results?.count, 0)
            case .failure:
                XCTFail("Expected success with empty list")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - Edge Case: Missing Results Field

    func testExecute_NilResultsInResponse() {
        // Arrange
        let mockResponse = CategoryResponse(count: 5, results: nil)
        mockRepo.result = .success(mockResponse)

        let expectation = expectation(description: "Expected nil-safe response")

        // Act
        useCase.execute(categoryRequest: CategoryRequest()) { result in
            // Assert
            switch result {
            case .success(let response):
                XCTAssertNil(response.results)
            case .failure:
                XCTFail("Expected success with nil results")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
