//
//  AppTransition.swift
//  Purchases
//
//  Created by User on 1/5/24.
//

enum AppTransition {
    case showHomeModule
    
    var identifier: String { String(describing: self).capitalized }
    
    func coordinatorFor<R: AppRouter>(router: R) -> Coordinator {
        return switch self {
            case .showHomeModule: HomeCoordinator(router: router)
        }
    }
}
