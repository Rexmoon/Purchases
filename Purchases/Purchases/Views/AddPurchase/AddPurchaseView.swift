//
//  AddPurchaseView.swift
//  Purchases
//
//  Created by User on 1/5/24.
//

import SwiftUI

struct AddPurchaseView<R: HomeRouter>: View {
    
    @State private var idText: String = "01"
    @State private var nameText: String = ""
    @State private var priceText: String = ""
    @State private var descriptionText: String = ""
    @State private var dateSelection: Date = Date.now
    
    private let viewModel: AddPurchaseViewModel<R>
    
    init(viewModel: AddPurchaseViewModel<R>) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationStack {
            
            VStack(alignment: .leading, spacing: 50) {
                
                textField(title: "Product id", state: $idText)
                    .disabled(true)
                
                textField(title: "Name", state: $nameText)
                
                textField(title: "Description", state: $descriptionText, isArea: true)
                
                textField(title: "Price", state: $priceText)
                
                DatePicker("Made on", selection: $dateSelection, in: ...Date.now, displayedComponents: [.date])
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        
                    } label: {
                        Text("Save")
                    }
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue)
                    }
                    .foregroundStyle(.white)
                }
            }
        }
    }
    
    private func textField(title: String, 
                           state: Binding<String>,
                           isArea: Bool = false) -> some View {
        VStack(alignment: .leading) {
            
            Text("\(title): ")
                .foregroundStyle(.blue)
            
            if isArea {
                TextEditor(text: $descriptionText)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(.gray)
                    }
            } else {
                TextField("Tap to add \(title)", text: state)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(.gray)
                    }
            }
        }
    }
}

#Preview {
    let app = App()
    let coordinator = HomeCoordinator(router: app)
    let viewModel = AddPurchaseViewModel(router: coordinator)
    return AddPurchaseView(viewModel: viewModel)
}
