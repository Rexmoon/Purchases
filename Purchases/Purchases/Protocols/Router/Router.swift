//
//  Router.swift
//  Purchases
//
//  Created by User on 1/5/24.
//

import UIKit

protocol Router {
    
    associatedtype Route
    
    var navController: UINavigationController { get set }
    
    func process(route: Route)
    func exit()
}
