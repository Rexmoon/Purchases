//
//  HomeView.swift
//  Purchases
//
//  Created by User on 1/5/24.
//

import SwiftUI

struct HomeView<R: HomeRouter>: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel: HomeViewModel<R>
    
    // MARK: - Initializers
    
    init(viewModel: HomeViewModel<R>) {
        self.viewModel = viewModel
    }
    
    // MARK: - Content
    
    var body: some View {
        
        ProgressContainer(validation: !viewModel.purchases.isEmpty) {
            ScrollView {
                LazyVGrid(columns: [.init(), .init()]) {
                    ForEach(viewModel.purchases, id: \.self) { purchase in
                        purchaseCell(for: purchase)
                    }
                }
            }
            .padding()
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
        .onAppear {
            viewModel.loadData()
        }
    }
    
    // MARK: - Purchase Cell View
    
    private func purchaseCell(for purchase: Purchase) -> some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                
                Spacer()
                
                Circle()
                    .frame(maxWidth: 10, maxHeight: 10)
                    .foregroundStyle(purchase.status == Status.sold.rawValue ? .red : .green)
            }
            
            Image(systemName: "00.square.fill")
                .resizable()
                .frame(width: 140, height: 180)
            
            Text(purchase.name)
                .lineLimit(1)
            
            Text("$\(purchase.price)")
                .lineLimit(1)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 1)
        }
        .onTapGesture {
            viewModel.didTapItem(by: purchase.id.stringValue)
        }
    }
}

// MARK: - Previews

#Preview {
    let app = App()
    let coordinator = HomeCoordinator(router: app)
    let viewModel = HomeViewModel(router: coordinator)
    
    viewModel.purchases = (1...100).map { .init(name: "Name \($0)",
                                                desc: "Description",
                                                price: $0 + 100,
                                                date: $0 + 1000) }
    
    return HomeView(viewModel: viewModel)
}
