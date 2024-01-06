//
//  HomeViewModel.swift
//  Purchases
//
//  Created by User on 1/5/24.
//

final class HomeViewModel<R: HomeRouter> {
    
    // MARK: - Properties
    
    var purchases: [Purchase] = (1...100).map { .init(name: "Name \($0)",
                                                      description: "Description",
                                                      price: $0 + 100,
                                                      date: $0 + 1000) }
    
    private let router: R
    
    // MARK: - Initializers
    
    init(router: R) {
        self.router = router
    }
}

// MARK: - Navigation Delegate

extension HomeViewModel {
    
    func didTapItem(in index: Int) { }
    
    func rightButtonClicked() {
        router.process(route: .showAddPurchaseView)
    }
}
