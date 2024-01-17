//
//  RoundedButton.swift
//  Purchases
//
//  Created by User on 1/16/24.
//

import SwiftUI

struct RoundedButton: View {
    
    // MARK: - Properties
    
    private let title: String
    private let color: Color
    
    // MARK: - Initializers
    
    init(title: String, color: Color = .blue) {
        self.title = title
        self.color = color
    }
    
    // MARK: - Content
    
    var body: some View {
        Text(title)
        .frame(maxWidth: .infinity)
        .padding()
        .foregroundStyle(.white)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
        }
    }
}

// MARK: - Preview

#Preview {
    RoundedButton(title: "Button", color: .red)
}
