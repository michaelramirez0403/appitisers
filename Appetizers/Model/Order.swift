//
//  Order.swift
//  Appetizers
//
//  Created by Michael Ramirez
//

import SwiftUI
final class Order: ObservableObject {
    @Published var items: [Appetizer] = []
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    func add(_ appetizer: Appetizer) {
        items.append(appetizer)
    }
    func deleteItems(at offesets: IndexSet) {
        items.remove(atOffsets: offesets)
    }
}
