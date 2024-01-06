//
//  HomeViewModel.swift
//  Purchases
//
//  Created by User on 1/5/24.
//

final class HomeViewModel<R: HomeRouter> {
    
    // MARK: - Properties
    
    var purchases: [String] = (1...100).map { "\($0)" }
    
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
