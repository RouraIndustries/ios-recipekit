//
//  CuisineTypeRecipesListView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/27/24.
//

import SwiftUI
import CloudKit

struct CuisineTypeRecipesListView: View {
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
            .padding(.horizontal, 16.0)
            .padding(.vertical, 4.0)
        }
    }
}

#Preview {
    NavigationStack {
        CuisineTypeRecipesListView(cuisineType: V0_CuisineType(record: CKRecord(recordType: RecordType.cuisineType)), recipes: [])
    }
}
