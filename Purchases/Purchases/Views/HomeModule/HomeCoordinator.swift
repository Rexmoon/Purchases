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
    
    private lazy var addPurchaseViewModel: AddOrEditPurchaseViewModel = {
        AddOrEditPurchaseViewModel(router: self)
    }()
    
    private var addPurchaseViewController: UIViewController {
        let view = AddOrEditPurchaseView(viewModel: addPurchaseViewModel)
        let viewController = UIHostingController(rootView: view)
        return viewController
    }
    
    private lazy var detailViewModel: DetailViewModel = {
        DetailViewModel(router: self)
    }()
    
    private lazy var detailViewController: UIViewController = {
        let view = DetailView(viewModel: detailViewModel)
        return UIHostingController(rootView: view)
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
                addPurchaseViewController.title = "Add Purchase"
                router.navController.pushViewController(addPurchaseViewController, animated: true)
                
            case .showDetailview(let objectId):
                detailViewModel.objectId = objectId
                router.navController.pushViewController(detailViewController, animated: true)
                
            case .showEditPurchaseView(let purchase):
                if let purchase {
                    addPurchaseViewModel.purchase = purchase
                    addPurchaseViewController.title = "Edit Purchase"
                }
                router.navController.pushViewController(addPurchaseViewController, animated: true)
        }
    }
    
    func exit() {
        router.navController.popViewController(animated: true)
    }
}
