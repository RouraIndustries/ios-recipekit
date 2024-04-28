//
//  RecipeCarouselView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/17/24.
//

import SwiftUI

enum RecipeListStyle {
    case carousel
    case list
}

struct RecipeCarouselView: View {
    var style: RecipeListStyle = .carousel
    let recipes: [V0_Recipe]

    var body: some View {
        switch style {
        case .carousel: carousel
        case .list: list
        }
    }

    var carousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16.0) {
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

    var list: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 16.0) {
                ForEach(recipes) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeCard(style: .large, recipe: recipe)
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
