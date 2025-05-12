//
//  ContentView.swift
//  Appetizers
//
//  Created by Michael Ramirez
//
import SwiftUI
struct AppetizerTabView: View {
    // MARK: - Properties
    @EnvironmentObject var order: Order
    // MARK: - Body
    var body: some View {
        TabView {
            homeTab
            accountTab
            orderTab
        }
    }
    // MARK: - Tab Items
    private var homeTab: some View {
        AppetizerListView()
            .tabItem { Label(Constant.homeTab,
                             systemImage: Constant.systemImagehome) }
    }
    private var accountTab: some View {
        AccountView()
            .tabItem { Label(Constant.accountTab,
                             systemImage: Constant.systemImageAccount) }
    }
    private var orderTab: some View {
        OrderView()
            .tabItem { Label(Constant.orderTab,
                             systemImage: Constant.systemImageOrder) }
            .badge(order.items.count)
    }
}
// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppetizerTabView()
            .environmentObject(Order())
    }
}
