//
//  NetworkManager.swift
//  Appetizers
//
//  Created by Michael Ramirez
//
//
//  NetworkManager.swift
//  Appetizers
//
//  Created by Michael Ramirez
//

import UIKit
protocol NetworkManagerProtocol {
    func getAppetizers() async throws -> [Appetizer]
}
final class NetworkManager: NetworkManagerProtocol {
    // MARK: - Properties
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    private let appetizerURL = Constant.appetizersURL
    // MARK: - Initializer
    public init() {}
    // MARK: - Methods
    func getAppetizers() async throws -> [Appetizer] {
        guard let url = URL(string: appetizerURL) else {
            throw APError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decodeAppetizerResponse(from: data)
    }
    func downloadImage(fromURLString urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let cachedImage = cache.object(forKey: cacheKey) {
            return cachedImage
        }
        guard let url = URL(string: urlString) else {
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
    // MARK: - Helper Methods
    private func decodeAppetizerResponse(from data: Data) throws -> [Appetizer] {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(AppetizerRespose.self,
                                      from: data).request
        } catch {
            throw APError.invalidData
        }
    }
}
//
@MainActor
final class MockNetworkManager: NetworkManagerProtocol {
    var mockAppetizers: [Appetizer] = []
    var shouldThrowError = false
    func getAppetizers() async throws -> [Appetizer] {
        if shouldThrowError {
            throw APError.invalidData
        }
        return mockAppetizers
    }
}
