//
//  HomeView.swift
//  Purchases
//
//  Created by User on 1/5/24.
//

import SwiftUI

struct HomeView<R: HomeRouter>: View {
    
    private let viewModel: HomeViewModel<R>
    
    init(viewModel: HomeViewModel<R>) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [.init(), .init()], spacing: 30) {
                    ForEach(viewModel.purchases, id: \.self) { item in
                        purchaseCell(for: item)
                    }
                }
                .padding()
            }
            .navigationTitle("Purchase")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.rightButtonClicked()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private func purchaseCell(for item: String) -> some View {
        VStack(alignment: .leading, spacing: 25) {
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 120, height: 120)
            
            Text("$\(item)")
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 1)
        }
    }
}

// MARK: - Previews

#Preview {
    let app = App()
    let coordinator = HomeCoordinator(router: app)
    let viewModel = HomeViewModel(router: coordinator)
    
    return HomeView(viewModel: viewModel)
}
