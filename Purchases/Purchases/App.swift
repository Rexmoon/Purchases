//
//  App.swift
//  Purchases
//
//  Created by User on 1/5/24.
//

import UIKit

final class App {
    
    var navController: UINavigationController = .init()
}

// MARK: - AppRouter Delegate

extension App: AppRouter {
    
    func process(route: AppTransition) {
        let coordinator = route.coordinatorFor(router: self)
        
        coordinator.start()
        
        print(route.identifier)
    }
    
    func exit() {
        navController.popToRootViewController(animated: true)
    }
}

// MARK: - Coordinator Delegate

extension App: Coordinator {
    
    func start() {
        process(route: .showHomeModule)
    }
}
