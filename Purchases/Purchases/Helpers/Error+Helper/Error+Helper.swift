//
//  Error+Helper.swift
//  Purchases
//
//  Created by User on 1/15/24.
//

import Foundation

enum StoreError: Error {
    case creating
    case reading
    case updating
    case deleting
    case generic(Error)
    
    var errorDescription: String? {
        return switch self {
            case .generic(let error): error.localizedDescription
            default: String(describing: self).capitalized
        }
    }
}
