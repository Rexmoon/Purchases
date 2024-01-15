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

// MARK: - Navigation Delegate

extension HomeViewModel {
    
    func loadData() {
        Task { @MainActor [unowned self] in
            do {
                purchases = try store.read()
            } catch {
                print(error)
            }
        }
    }
    
    func didTapItem(in index: Int) { }
    
    func rightButtonClicked() {
        router.process(route: .showAddPurchaseView)
    }
}
