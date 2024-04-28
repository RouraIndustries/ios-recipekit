//
//  RecipeCarouselView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/17/24.
//

import SwiftUI

struct RecipeCarouselView: View {
    let recipes: [V0_Recipe]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16.0) {
                ForEach(recipes) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeCard(recipe: recipe)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, 16.0, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    NavigationStack {
        RecipeCarouselView(recipes: [])
    }
}
