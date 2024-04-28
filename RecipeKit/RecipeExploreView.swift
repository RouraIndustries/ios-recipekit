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
                            RecipeCarouselView(
                                style: cuisineType.id == recipeManager.cuisineTypes.last?.id ? .list : .carousel,
                                recipes: viewModel.recipesForCuisineType(cuisineType)
                            )
                        } header: {
                            NavigationLink(value: cuisineType) {
                                HStack {
                                    Text(cuisineType.cuisineType.rawValue)

                                    Spacer()
                                    
                                    HStack(spacing: 2.0) {
                                        Text("See all")
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 8, height: 8)
                                            .fontWeight(.bold)
                                    }
                                }
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
            .navigationDestination(for: V0_CuisineType.self) { cuisineType in
                CuisineTypeRecipesListView(cuisineType: cuisineType, recipes: viewModel.recipesForCuisineType(cuisineType))
            }
            .navigationDestination(for: V0_Recipe.self) { recipe in
                RecipeDetailsView(recipe: recipe)
            }
        }
    }
}

#Preview {
    RecipeExploreView()
}
