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
final class NetworkManager {
    // MARK: - Properties
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    private let appetizerURL = Constant.appetizersURL
    // MARK: - Initializer
    private init() {}
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
//import UIKit
//final class NetworkManager {
//    static let shared = NetworkManager()
//    private let cache = NSCache<NSString, UIImage>()
//    static let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
//    private let appetizerURL = baseURL + "appetizers"
//    private init() {}
//    func getAppetizers() async throws -> [Appetizer] {
//        guard let url = URL(string: appetizerURL) else {
//            throw APError.invalidURL
//        }
//        let (data, _) = try await URLSession.shared.data(from: url)
//        do {
//            let decoder = JSONDecoder()
//            return try decoder.decode(AppetizerRespose.self, from: data).request
//        } catch {
//            throw APError.invalidData
//        }
//    }
//    func downloadImage(fromURLString urlString: String,
//                       completed: @escaping (UIImage?) -> Void ) {
//        let cacheKey = NSString(string: urlString)
//        if let image = cache.object(forKey: cacheKey) {
//            completed(image)
//            return
//        }
//        guard let url = URL(string: urlString) else {
//            completed(nil)
//            return
//        }
//        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
//            guard let data = data, let image = UIImage(data: data) else {
//                completed(nil)
//                return
//            }
//            self.cache.setObject(image, forKey: cacheKey)
//            completed(image)
//        }
//        task.resume()
//    }
//}
