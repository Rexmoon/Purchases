//
//  AddPurchaseView.swift
//  Purchases
//
//  Created by User on 1/5/24.
//

import SwiftUI

struct AddPurchaseView<R: HomeRouter>: View {
    
    @State private var nameText: String = ""
    @State private var priceText: String = ""
    @State private var descriptionText: String = ""
    @State private var dateSelection: Date = Date.now
    @State private var showAlert: Bool = false
    
    private let viewModel: AddPurchaseViewModel<R>
    
    init(viewModel: AddPurchaseViewModel<R>) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 50) {
                    
                    textField(title: "Name", state: $nameText)
                    
                    textField(title: "Description", state: $descriptionText, isArea: true)
                    
                    textField(title: "Price", state: $priceText, keyboardType: .numberPad)
                    
                    DatePicker("Made on", selection: $dateSelection, in: ...Date.now, displayedComponents: [.date])
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            
                            guard !nameText.isEmpty,
                                  !descriptionText.isEmpty,
                                  !priceText.isEmpty
                            else {
                                showAlert.toggle()
                                return
                            }
                            
                            viewModel.createItemWith(name: nameText,
                                                     desc: descriptionText,
                                                     price: priceText,
                                                     date: dateSelection)
                        } label: {
                            Text("Save")
                        }
                        .padding(.horizontal)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.blue)
                        }
                        .foregroundStyle(.white)
                        .alert("Some properties are required!", isPresented: $showAlert) {
                            Text("Ok")
                        }
                    }
                }
            }
        }
    }
    
    private func textField(title: String, 
                           state: Binding<String>,
                           isArea: Bool = false,
                           keyboardType: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading) {
            
            Text("\(title): ")
                .foregroundStyle(.blue)
            
            if isArea {
                TextEditor(text: $descriptionText)
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(Color(.gray.withAlphaComponent(0.3)))
                    }
            } else {
                TextField(title, text: state)
                    .keyboardType(keyboardType)
                    .textFieldStyle(.roundedBorder)
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
