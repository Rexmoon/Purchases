//
//  ProgressContainer.swift
//  Purchases
//
//  Created by User on 1/16/24.
//

import SwiftUI

struct ProgressContainer<Content: View>: View {
    
    // MARK: - Properties
    
    private var validation: Bool
    
    private let content: Content
    
    // MARK: - Initializers
    
    init(validation: Bool, 
         @ViewBuilder content: ()-> Content) {
        self.validation = validation
        self.content = content()
    }
    
    // MARK: - Content
    
    var body: some View {
        
        NavigationStack {
            if validation {
                content
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ProgressContainer(validation: false) {
        Text("Hi")
    }
}
