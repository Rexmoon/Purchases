//
//  HomeTransition.swift
//  Purchases
//
//  Created by User on 1/5/24.
//

enum HomeTransition {
    case showAddPurchaseView
    case showDetailview(String)
    case showEditPurchaseView(Purchase?)
    
    var identifier: String { String(describing: self).capitalized }
}
