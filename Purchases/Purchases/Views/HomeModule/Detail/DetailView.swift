//
//  DetailView.swift
//  Purchases
//
//  Created by User on 1/15/24.
//

import SwiftUI

struct DetailView<R: HomeRouter>: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel: DetailViewModel<R>
    
    @State private var tabSelection: Int = 0
    
    
    // MARK: - Initializers
    
    init(viewModel: DetailViewModel<R>) {
        self.viewModel = viewModel
    }
    
    // MARK: - Content
    
    var body: some View {
        
        ProgressContainer(validation: viewModel.purchase != nil) {
            GeometryReader { proxy in
                
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        
                        // TODO: - Fill with real Images collection
                        tabImageView(with: (0...9).map { $0 })
                            .frame(width: proxy.size.width * 0.9,
                                   height: proxy.size.width * 0.8)
                        
                        detailSection(title: "Name", content: viewModel.purchase?.name)
                        
                        detailSection(title: "Price", content: "$ \(viewModel.purchase?.price ?? 0)")
                        
                        detailSection(title: "Description", content: viewModel.purchase?.desc)
                        
                        detailSection(title: "Purchase Status", content: viewModel.purchase?.status)
                            .overlay(alignment: .trailing) {
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(viewModel.purchase?.status == Status.available.rawValue ? .green : .red)
                            }
                    }
                }
                .padding(.horizontal)
            }
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        
                        RoundedButton(title: "Edit")
                            .onTapGesture {
                                viewModel.editButtonClicked()
                            }
                        
                        RoundedButton(title: "Delete", color: .red)
                            .onTapGesture {
                                viewModel.deleteButtonClicked()
                            }
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadData()
        }
    }
    
    // MARK: - Functions
    
    private func tabImageView(with images: [Int]) -> some View {
        TabView(selection: $tabSelection) {
            
            ForEach(images, id: \.self) { index in
                
                Image(systemName: "camera")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(alignment: .bottomLeading) {
                        Text("\(index + 1)/\(images.count)")
                            .foregroundStyle(.white)
                            .background(.black)
                            .padding(20)
                    }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func detailSection(title: String, content: String?) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
            
            Text(content ?? "Content")
                .font(.subheadline)
            
            Divider()
        }
    }
}

// MARK: - Preview

#Preview {
    let app = App()
    let coordinator = HomeCoordinator(router: app)
    let viewModel = DetailViewModel(router: coordinator)
    viewModel.objectId = "65a58e24ac85ba007f803bcf"
    return DetailView(viewModel: viewModel)
}
