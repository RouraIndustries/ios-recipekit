//
//  SafeAreaButtonGradient.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 3/29/24.
//

import SwiftUI
import Tuxedo

struct SafeAreaButtonGradient: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color.backgroundPrimary.opacity(0.8),
                Color.backgroundPrimary
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
