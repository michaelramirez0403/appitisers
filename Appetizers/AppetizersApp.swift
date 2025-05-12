//
//  AppetizersApp.swift
//  Appetizers
//
//  Created by Michael Ramirez
//
import SwiftUI
@main
struct AppetizersApp: App {
    var order = Order()
    var body: some Scene {
        WindowGroup {
            AppetizerTabView().environmentObject(order)
        }
    }
}
