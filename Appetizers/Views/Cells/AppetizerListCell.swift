//
//  AppetizerListCell.swift
//  Appetizers
//
//  Created by Michael Ramirez
//
import SwiftUI
struct AppetizerListCell: View {
    // MARK: - Properties
    let appetizer: Appetizer
    // MARK: - Body
    var body: some View {
        VStack {
            appetizerImage
            appetizerInfo
        }
    }
    // MARK: - Subviews
    private var appetizerImage: some View {
        AsyncImage(url: URL(string: appetizer.imageURL)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 90)
                .cornerRadius(8)
        } placeholder: {
            placeholderImage
        }
    }
    private var appetizerInfo: some View {
        VStack(alignment: .leading,
               spacing: 5) {
            Text(appetizer.name)
                .font(.title3)
                .fontWeight(.medium)
            Text("$\(appetizer.price, specifier: "%.2f")")
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
        }
        .padding(.leading)
    }
    private var placeholderImage: some View {
        Image("food-placeholder")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 120, height: 90)
            .cornerRadius(8)
    }
}
// MARK: - Preview
struct AppetizerListCell_Previews: PreviewProvider {
    static var previews: some View {
        AppetizerListCell(appetizer: MockData.sampleAppetizer)
    }
}
