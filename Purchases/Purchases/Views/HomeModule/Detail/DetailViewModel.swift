//
//  DetailViewModel.swift
//  Purchases
//
//  Created by User on 1/15/24.
//

import Foundation

final class DetailViewModel<R: HomeRouter>: ObservableObject {
    
    // MARK: - Properties

    @Published var purchase: Purchase?
    
    var objectId: String = ""
    
    private let router: R
    private let store: PurchaseStore
    
    // MARK: - Initializers
    
    init(router: R, 
         store: PurchaseStore = RealmRepository()) {
        self.router = router
        self.store = store
    }
}

// MARK: - Navigation

extension DetailViewModel {
    
    func didTapBackButton() {
        router.exit()
    }
    
    func editButtonClicked() {
        router.process(route: .showEditPurchaseView(purchase))
    }
    
    func deleteButtonClicked() {
        
    }
}

// MARK: - Store

extension DetailViewModel {
    
    func loadData() {
        Task { @MainActor [unowned self] in
            do {
                /// For ProgressContainet test
                try await Task.sleep(for: .seconds(1))
                purchase = try store.get(by: objectId)
            } catch {
                print(error)
            }
        }
    }
}
