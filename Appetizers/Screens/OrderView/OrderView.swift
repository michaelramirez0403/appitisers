//
//  OrderView.swift
//  Appetizers
//
//  Created by Michael Ramirez
//
//
import SwiftUI
struct OrderView: View {
    @EnvironmentObject var order: Order
    var body: some View {
        NavigationView {
            ZStack {
                if order.items.isEmpty {
                    EmptyOrderView()
                } else {
                    OrderListView(order: order)
                }
            }
            .navigationTitle("🧾 Orders")
        }
    }
}
struct EmptyOrderView: View {
    var body: some View {
        EmptyState(imageName: "empty-order",
                   message: "You have no items in your order.\nPlease add an appetizer!")
    }
}
struct OrderListView: View {
    @ObservedObject var order: Order
    var body: some View {
        VStack {
            List {
                ForEach(order.items) { appetizer in
                    AppetizerListCell(appetizer: appetizer)
                }
                .onDelete(perform: order.deleteItems)
            }
            .listStyle(PlainListStyle())
            
            Button {
                print("order placed")
            } label: {
                Text("$\(order.totalPrice, specifier: "%.2f") - Place Order")
            }
            .modifier(StandardButtonStyle())
            .padding(.bottom, 25)
        }
    }
}
struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
