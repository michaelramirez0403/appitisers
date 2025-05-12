//
//  RemoteImage.swift
//  Appetizers
//
//  Created by Michael Ramirez
//

import SwiftUI
// MARK: - Image Loader
@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: Image? = nil
    func load(fromURLString urlString: String) async {
        guard let uiImage = await NetworkManager.shared.downloadImage(fromURLString: urlString) else { return }
        self.image = Image(uiImage: uiImage)
    }
}
// MARK: - Remote Image View
struct RemoteImage: View {
    let image: Image?
    var body: some View {
        if let image = image {
            image.resizable()
        } else {
            placeholderImage
        }
    }
    private var placeholderImage: some View {
        Image("food-placeholder")
            .resizable()
    }
}

// MARK: - Appetizer Remote Image View
struct AppetizerRemoteImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let urlString: String
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .task {
                await imageLoader.load(fromURLString: urlString)
            }
    }
}
