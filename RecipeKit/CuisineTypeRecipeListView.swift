//
//  CuisineTypeRecipeListView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/28/24.
//

import SwiftUI
import CloudKit

struct CuisineTypeRecipeListView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.recipeManager) private var recipeManager

    let cuisineType: V0_CuisineType
    let recipes: [V0_Recipe]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16.0) {
                ForEach(recipes) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeCard(style: .large, recipe: recipe)
                    }
                    .buttonStyle(.plain)
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
        CuisineTypeRecipeListView(cuisineType: V0_CuisineType(record: CKRecord(recordType: RecordType.cuisineType)), recipes: [])
    }
}
