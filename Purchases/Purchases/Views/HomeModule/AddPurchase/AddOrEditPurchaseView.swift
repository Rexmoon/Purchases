//
//  AddPurchaseView.swift
//  Purchases
//
//  Created by User on 1/5/24.
//

import SwiftUI

struct AddOrEditPurchaseView<R: HomeRouter>: View {
    
    // MARK: - Properties
    
    @State private var nameText: String = ""
    @State private var priceText: String = ""
    @State private var descriptionText: String = ""
    @State private var dateSelection: Date = Date.now
    @State private var showAlert: Bool = false
    
    private let viewModel: AddOrEditPurchaseViewModel<R>
    
    // MARK: - Initializers
    
    init(viewModel: AddOrEditPurchaseViewModel<R>) {
        self.viewModel = viewModel
    }
    
    // MARK: - Content
    
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
                            validateSaving()
                        } label: {
                            RoundedButton(title: "Save")
                        }
                        .alert("Fill missing properties!", isPresented: $showAlert) {
                            Text("Ok")
                        }
                    }
                }
                .onAppear {
                    fillToUpdate()
                }
            }
        }
    }
    
    // MARK: - Functions
    
    private func validateSaving() {
        guard !nameText.isEmpty,
              !descriptionText.isEmpty,
              !priceText.isEmpty 
        else {
            showAlert.toggle()
            return
        }
        
        viewModel.createOrEditItemWith(name: nameText,
                                       desc: descriptionText,
                                       price: priceText,
                                       date: dateSelection)
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
    
    private func fillToUpdate() {
        
        guard let purchase = viewModel.purchase else { return }
        
        nameText = purchase.name
        priceText = "\(purchase.price)"
        descriptionText = purchase.desc
        dateSelection = purchase.date.toDate()
    }
}

// MARK: - Preview

#Preview {
    let app = App()
    let coordinator = HomeCoordinator(router: app)
    let viewModel = AddOrEditPurchaseViewModel(router: coordinator)
    return AddOrEditPurchaseView(viewModel: viewModel)
}
