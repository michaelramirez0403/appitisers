//
//  AppetizerListViewModel.swift
//  Appetizers
//
//  Created by Michael Ramirez
//
import SwiftUI
@MainActor
final class AppetizerListViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var appetizers: [Appetizer] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var isShowingDetail = false
    @Published var selectedAppetizer: Appetizer?
    // MARK: - Methods
    func getAppetizers() {
        isLoading = true
        Task {
            do {
                appetizers = try await NetworkManager.shared.getAppetizers()
            } catch {
                alertItem = mapErrorToAlertItem(error)
            }
            isLoading = false
        }
    }
    // MARK: - Helper Methods
    private func mapErrorToAlertItem(_ error: Error) -> AlertItem {
        if let apError = error as? APError {
            switch apError {
            case .invalidURL:
                return AlertContext.invalidURL
            case .invalidResponse:
                return AlertContext.invalidResponse
            case .invalidData:
                return AlertContext.invalidData
            case .unableToComplete:
                return AlertContext.unableToComplete
            }
        }
        return AlertContext.invalidResponse
    }
}
