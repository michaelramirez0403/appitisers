//
//  CustomModifiers.swift
//  Appetizers
//
//  Created by Michael Ramirez
//

import SwiftUI
// MARK: - StandardButtonStyle Modifier
struct StandardButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .tint(.brandPrimary)
            .controlSize(.large)
    }
}
extension View {
    func standardButtonStyle() -> some View {
        self.modifier(StandardButtonStyle())
    }
}
