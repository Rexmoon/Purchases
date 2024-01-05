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
            
            List(viewModel.purchases, id: \.self) { item in
                Text(item)
            }
            .navigationTitle("Purchases")
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

// MARK: - Previews

#Preview {
    
    typealias R = HomeRouter
    
    let app = App()
    let coordinator = HomeCoordinator(router: app)
    let viewModel = HomeViewModel(router: coordinator)
    
    return HomeView(viewModel: viewModel)
}
