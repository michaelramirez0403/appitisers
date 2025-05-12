//
//  AppetizerListView.swift
//  Appetizers
//
//  Created by Michael Ramirez
//
import SwiftUI
struct AppetizerListView: View {
    // MARK: - Properties
    @StateObject var viewModel = AppetizerListViewModel()
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    // MARK: - Body
    var body: some View {
        ZStack {
            NavigationView {
                appetizerGrid
                    .navigationTitle("🍟 Appetizers")
                    .disabled(viewModel.isShowingDetail)
            }
            .task {
                viewModel.getAppetizers()
            }
            .blur(radius: viewModel.isShowingDetail ? 20 : 0)
            
            if viewModel.isShowingDetail {
                detailView
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
    // MARK: - Subviews
    private var appetizerGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns,
                      spacing: 16) {
                ForEach(viewModel.appetizers) { appetizer in
                    ZStack {
                        AppetizerListCell(appetizer: appetizer)
                    }
                    .onTapGesture {
                        viewModel.selectedAppetizer = appetizer
                        viewModel.isShowingDetail = true
                    }
                }
            }
            .padding()
        }
    }
    
    private var detailView: some View {
        AppetizerDetailView(appetizer: viewModel.selectedAppetizer!,
                            isShowingDetail: $viewModel.isShowingDetail)
    }
}

struct AppetizerListView_Previews: PreviewProvider {
    static var previews: some View {
        AppetizerListView()
    }
}
