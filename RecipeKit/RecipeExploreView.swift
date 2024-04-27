//
//  RecipeExploreView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/17/24.
//

import SwiftUI

struct RecipeExploreView: View {
    @Environment(\.recipeManager) private var recipeManager
    @Environment(\.cloudKitManager) private var cloudKitManager

    @State private var viewModel = ViewModel()

    @State private var showCreateRecipeView = false

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12.0) {
                    ForEach(recipeManager.cuisineTypes) { cuisineType in
                        Section {
                            RecipeCarouselView(recipes: viewModel.recipesForCuisineType(cuisineType))
                        } header: {
                            NavigationLink(value: cuisineType) {
                                Text(cuisineType.cuisineType.rawValue)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16.0)
                        }
                    }
                }
            }
            .task {
                viewModel.recipeManager = recipeManager
                viewModel.cloudKitManager = cloudKitManager
                await viewModel.fetchDataTaskGroup()
            }
            .refreshable { await viewModel.fetchDataTaskGroup() }
            .overlay { if viewModel.isLoading { LoadingView() }}
            .navigationDestination(for: String.self) { category in
                Text(category)
            }
            .navigationDestination(for: V0_Recipe.self) { recipe in
                Text(recipe.recipeTitle)
            }
        }
    }
}

#Preview {
    RecipeExploreView()
}
