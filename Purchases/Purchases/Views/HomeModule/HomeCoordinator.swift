//
//  HomeCoordinator.swift
//  Purchases
//
//  Created by User on 1/5/24.
//

import UIKit
import SwiftUI

final class HomeCoordinator<R: AppRouter> {
    
    // MARK: - Properties
    
    private var router: R
    
    private lazy var homeViemodel: HomeViewModel = {
        HomeViewModel(router: self)
    }()
    
    private lazy var homeViewController: UIViewController = {
        let view = HomeView(viewModel: homeViemodel)
        let viewController = UIHostingController(rootView: view)
        return viewController
    }()
    
    private lazy var addPurchaseViewModel: AddPurchaseViewModel = {
        AddPurchaseViewModel(router: self)
    }()
    
    private lazy var addPurchaseViewController: UIViewController = {
        let view = AddPurchaseView(viewModel: addPurchaseViewModel)
        let viewController = UIHostingController(rootView: view)
        
        viewController.title = "Add Purchase"
        
        return viewController
    }()
    
    // MARK: - Initializers
    
    init(router: R) {
        self.router = router
    }
}

// MARK: - Coordinator Delegate

extension HomeCoordinator: Coordinator {
    
    func start() {
        router.navController.pushViewController(homeViewController, animated: true)
    }
}

// MARK: - HomeRouter Delegate

extension HomeCoordinator: HomeRouter {
    var navController: UINavigationController {
        get { router.navController }
        set { router.navController = newValue }
    }
    
    func process(route: HomeTransition) {
        switch route {
            case .showAddPurchaseView:
                router.navController.pushViewController(addPurchaseViewController, animated: true)
        }
    }
    
    func exit() {
        router.navController.popViewController(animated: true)
    }
}
