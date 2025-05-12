//
//  AppetizerListViewModelTest.swift
//  Appetizers
//
//  Created by Macky Ramirez
//
import XCTest
@testable import Appetizers

final class AppetizerListViewModelTests: XCTestCase {
    var viewModel: AppetizerListViewModel!
    var mockNetworkManager: MockNetworkManager!
    @MainActor
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = AppetizerListViewModel(networkManager: mockNetworkManager)
    }
    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    func testGetAppetizersSuccess() async {
        // Arrange
        await MainActor.run {
            mockNetworkManager.mockAppetizers = [MockData.sampleAppetizer] // Wrap in an array
        }
        // Act
        await viewModel.getAppetizers()
        // Assert
        await MainActor.run {
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertEqual(viewModel.appetizers.count, 1)
            XCTAssertEqual(viewModel.appetizers.first?.name, "Test Appetizer")
        }
    }
    func testGetAppetizersFailure() async {
        // Arrange
        await MainActor.run {
            mockNetworkManager.shouldThrowError = true
        }
        // Act
        await viewModel.getAppetizers()
        // Assert
        await MainActor.run {
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertNotNil(viewModel.alertItem)
            XCTAssertEqual(viewModel.appetizers.count, 0)
        }
    }
}

