//
//  Error+Helper.swift
//  Purchases
//
//  Created by User on 1/15/24.
//

import Foundation

enum Error: LocalizedError {
    case creating
    case reading
    case updating
    case deleting
    
    var errorDescription: String? {
        String(describing: self).capitalized
    }
}
