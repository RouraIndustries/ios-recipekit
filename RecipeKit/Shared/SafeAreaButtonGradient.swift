//
//  SafeAreaButtonGradient.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 3/29/24.
//

import SwiftUI

struct SafeAreaButtonGradient: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color(.systemBackground).opacity(0.15),
                Color(.systemBackground)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea(edges: .bottom)
        .blur(radius: 8.0)
    }
}

#Preview {
    SafeAreaButtonGradient()
}
