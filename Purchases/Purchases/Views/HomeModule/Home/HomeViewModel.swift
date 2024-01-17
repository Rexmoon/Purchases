//
//  HomeViewModel.swift
//  Purchases
//
//  Created by User on 1/5/24.
//

import Foundation

final class HomeViewModel<R: HomeRouter>: ObservableObject {
    
    // MARK: - Properties
    
    @Published var purchases: [Purchase] = []
    
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

extension HomeViewModel {
    
    @MainActor
    func loadData() {
        Task { [unowned self] in
            do {
                purchases = try store.read()
                
                if purchases.isEmpty {
                    rightButtonClicked()
                }
            } catch {
                print(error)
            }
        }
    }
    
    func didTapItem(by id: String) {
        guard let purchase = purchases.first(where: { $0.id.stringValue == id }) else { return }
        router.process(route: .showDetailview(purchase.id.stringValue))
    }
    
    func rightButtonClicked() {
        router.process(route: .showAddPurchaseView)
    }
}
