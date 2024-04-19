//
//  CreateRecipeView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/18/24.
//

import SwiftUI
import SwiftData

struct CreateRecipeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var recipes: [Recipe]

    @State private var recipeTitle = ""
    @State private var recipeSummary = ""
    @State private var recipeCuisineType = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Recipe title", text: $recipeTitle)

                TextField("Recipe summary", text: $recipeSummary)

                TextField("Recipe cuisine type", text: $recipeCuisineType)

                Button("Create") {
                    let newRecipe = Recipe(
                        title: recipeTitle,
                        summary: recipeSummary,
                        instructions: []
                    )
                    let cuisineType = CuisineType(type: recipeCuisineType)
                    newRecipe.cuisineTypes?.append(cuisineType)

                    modelContext.insert(newRecipe)

                    recipeTitle.removeAll()
                    recipeSummary.removeAll()
                    recipeCuisineType.removeAll()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .navigationTitle("Create Recipe View")
        }
    }
}

#Preview {
    CreateRecipeView()
}
