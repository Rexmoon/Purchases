//
//  AddPurchaseViewModel.swift
//  Purchases
//
//  Created by User on 1/5/24.
//

final class AddPurchaseViewModel<R: HomeRouter> {
    
    private let router: R
    
    init(router: R) {
        self.router = router
    }
}

// MARK: - Navigation

extension AddPurchaseViewModel {
    
    func didTapBackButton() {
        router.exit()
    }
}
