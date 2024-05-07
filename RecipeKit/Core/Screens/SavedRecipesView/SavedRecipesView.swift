//
//  SavedRecipesView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/17/24.
//

import SwiftUI
import SwiftData
import Tuxedo

struct SavedRecipesView: View {
    static let tag: String? = String(describing: Self.self)
    @Environment(\.recipeManager) private var recipeManager
    @Environment(\.cloudKitManager) private var cloudKitManager

    @Query(sort: [SortDescriptor(\SavedRecipe.recipeID)]) var savedRecipes: [SavedRecipe]

    @State private var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16.0) {
                    ForEach(getSavedRecipes()) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeCard(style: .small, recipe: recipe)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .contentMargins(.horizontal, 16.0, for: .scrollContent)
            .padding(.vertical, 12.0)
            .background(.backgroundPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Saved recipes")
                        .tuxedoFont(.h4)
                        .foregroundStyle(.foregroundPrimary)
                }
            }
            .navigationDestination(for: V0_Recipe.self) { recipe in
                RecipeDetailsView(recipe: recipe)
            }
            .task {
                    viewModel.recipeManager = recipeManager
                    viewModel.cloudKitManager = cloudKitManager
                    await viewModel.fetchDataTaskGroup()
            }
            .refreshable {
                await viewModel.fetchDataTaskGroup()
            }
            .alert($viewModel.error)
            .overlay {
                if savedRecipes.isEmpty {
                    EmptyStateView(title: "No Saved Recipes", systemImage: "bookmark.slash", description: "You haven't saved any recipes yet. Start saving recipes to see them here.")
                }
            }
        }
    }

    func getSavedRecipes() -> [V0_Recipe] {
        let savedRecipeIDs = savedRecipes.map { $0.recipeID }
        return recipeManager.recipes.filter { savedRecipeIDs.contains($0.ckRecordID.recordName) }
    }
}

#Preview {
    SavedRecipesView()
}
