//
//  RecipesUseCaseTests.swift
//  MealAppTests
//
//  Created by Yousuf Abdelfattah on 24/05/2025.
//

import XCTest
import Factory
@testable import MealApp



// MARK: - RecipiesUseCaseTests

final class RecipiesUseCaseTests: XCTestCase {

    var useCase: RecipiesUseCase!
    var mockRepo: MockRecipiesRepository!

    // MARK: - Setup / Teardown

    override func setUp() {
        super.setUp()
        mockRepo = MockRecipiesRepository()
        Container.shared.recipiesRepository.register { self.mockRepo }
        useCase = RecipiesUseCase()
    }

    override func tearDown() {
        useCase = nil
        mockRepo = nil
        super.tearDown()
    }

    // MARK: - Success Scenario

    func testExecute_SuccessScenario() {
        // Arrange
        let expected = RecipesResponse.mock
        mockRepo.result = .success(expected)
        let request = RecipiesRequest(from: 0, size: 3)

        let expectation = self.expectation(description: "Expected success callback")

        // Act
        useCase.exectute(recipiesRequest: request) { result in
            // Assert
            switch result {
            case .success(let response):
                XCTAssertEqual(response.results.count, expected.results.count)
                XCTAssertEqual(response.count, expected.count)
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
        enum MockError: Error { case networkError }
        mockRepo.result = .failure(MockError.networkError)
        let request = RecipiesRequest(from: 0, size: 3)

        let expectation = self.expectation(description: "Expected failure callback")

        // Act
        useCase.exectute(recipiesRequest: request) { result in
            // Assert
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
                if case MockError.networkError = error {
                    // Success
                } else {
                    XCTFail("Expected MockError.networkError but got different error")
                }
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - Edge Case: Empty Response

    func testExecute_EmptyResponse() {
        // Arrange
        let emptyResponse = RecipesResponse(count: 0, results: [])
        mockRepo.result = .success(emptyResponse)

        let expectation = self.expectation(description: "Expected success with empty response")

        // Act
        useCase.exectute(recipiesRequest: RecipiesRequest(from: 0, size: 0)) { result in
            // Assert
            switch result {
            case .success(let response):
                XCTAssertEqual(response.count, 0)
                XCTAssertTrue(response.results.isEmpty)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - Parameterized Request Test

    func testExecute_WithSpecificRequestParameters() {
        // Arrange
        let request = RecipiesRequest(from: 10, size: 5, tags: "under_30_minutes", q: "pasta")
        let mockResponse = RecipesResponse.mock
        mockRepo.result = .success(mockResponse)

        let expectation = self.expectation(description: "Expected filtered response")

        // Act
        useCase.exectute(recipiesRequest: request) { result in
            // Assert
            switch result {
            case .success(let response):
                XCTAssertEqual(response.results.count, mockResponse.results.count)
            case .failure:
                XCTFail("Expected success with specific params")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
