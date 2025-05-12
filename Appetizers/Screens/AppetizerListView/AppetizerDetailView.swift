//
//  AppetizerDetailView.swift
//  Appetizers
//
//  Created by Michael Ramirez
//

import SwiftUI
struct AppetizerDetailView: View {
    // MARK: - Properties
    @EnvironmentObject var order: Order
    let appetizer: Appetizer
    @Binding var isShowingDetail: Bool
    // MARK: - Body
    var body: some View {
        VStack {
            AppetizerImageSection(appetizer: appetizer)
            AppetizerInfoSection(appetizer: appetizer)
            Spacer()
            AddToOrderButton(appetizer: appetizer,
                             isShowingDetail: $isShowingDetail)
        }
        .frame(width: 300, height: 525)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
        .overlay(
            CloseButton(isShowingDetail: $isShowingDetail),
            alignment: .topTrailing
        )
    }
}
// MARK: - Subviews
struct AppetizerImageSection: View {
    let appetizer: Appetizer
    var body: some View {
        AppetizerRemoteImage(urlString: appetizer.imageURL)
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 225)
    }
}
struct AppetizerInfoSection: View {
    let appetizer: Appetizer
    var body: some View {
        VStack {
            Text(appetizer.name)
                .font(.title2)
                .fontWeight(.semibold)
            Text(appetizer.description)
                .multilineTextAlignment(.center)
                .font(.body)
                .padding()
            HStack(spacing: 40) {
                NutritionInfo(title: "Calories",
                              value: "\(appetizer.calories)")
                NutritionInfo(title: "Carbs",
                              value: "\(appetizer.carbs) g")
                NutritionInfo(title: "Protein",
                              value: "\(appetizer.protein) g")
            }
        }
    }
}
struct AddToOrderButton: View {
    let appetizer: Appetizer
    @Binding var isShowingDetail: Bool
    @EnvironmentObject var order: Order
    var body: some View {
        Button {
            order.add(appetizer)
            isShowingDetail = false
        } label: {
            Text("$\(appetizer.price, specifier: "%.2f") - Add to Order")
        }
        .modifier(StandardButtonStyle())
        .padding(.bottom, 30)
    }
}
struct CloseButton: View {
    @Binding var isShowingDetail: Bool
    var body: some View {
        Button {
            isShowingDetail = false
        } label: {
            XDismissButton()
        }
    }
}
// MARK: - NutritionInfo View
struct NutritionInfo: View {
    let title: String
    let value: String
    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .bold()
                .font(.caption)
            Text(value)
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
                .italic()
        }
    }
}
// MARK: - Preview
struct AppetizerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AppetizerDetailView(appetizer: MockData.sampleAppetizer,
                            isShowingDetail: .constant(true))
            .environmentObject(Order())
    }
}
