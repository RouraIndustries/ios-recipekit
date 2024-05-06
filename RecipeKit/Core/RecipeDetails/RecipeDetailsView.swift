//
//  RecipeDetailsView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/27/24.
//

import SwiftUI
import CloudKit
import Tuxedo
import SwiftData

struct RecipeDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(\.recipeManager) private var recipeManager
    @Environment(\.cloudKitManager) private var cloudKitManager
    @Query(sort: [SortDescriptor(\SavedRecipe.recipeID)]) var savedRecipes: [SavedRecipe]
    @State private var viewModel: ViewModel

    let recipe: V0_Recipe

    init(recipe: V0_Recipe) {
        self.recipe = recipe
        _viewModel = State(wrappedValue: ViewModel(recipe: recipe))
    }

    var ingredients: [V0_Ingredient] {
        recipeManager.ingredients
            .filter { $0.recipe?.recordID == recipe.ckRecordID }
            .sorted { $0.ingredientName < $1.ingredientName }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12.0) {
                recipe.bannerImage
                    .resizable()
                    .scaledToFill()
                    .frame(
                        minWidth: .zero,
                        maxWidth: .infinity,
                        minHeight: .zero,
                        maxHeight: 180
                    )
                    .clipped()
                    .zIndex(-1.0)

                Group {
                    VStack(spacing: 8.0) {
                        if viewModel.mealType.isEmpty == false {
                            Text(viewModel.mealType)
                                .tuxedoFont(.captionExtraBold)
                                .foregroundStyle(.foregroundPrimary)
                        }

                        Text(recipe.recipeContent)
                            .lineLimit(3)
                            .minimumScaleFactor(0.75)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }

                    HStack(alignment: .firstTextBaseline, spacing: 8.0) {
                        ForEach(recipeManager.stats.filter { $0.recipe?.recordID == recipe.ckRecordID }.sorted { $0.statName < $1.statName}) { stat in
                            VStack(spacing: 2.0) {
                                Text(stat.statUnitLabel)
                                    .tuxedoFont(.captionBold)
                                    .foregroundStyle(.foregroundPrimary)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)

                                Text(stat.statName)
                                    .tuxedoFont(.caption)
                                    .foregroundStyle(.foregroundSecondary)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
                                    .minimumScaleFactor(0.5)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }

                    HStack(alignment: .firstTextBaseline, spacing: 8.0) {
                        ForEach(recipeManager.macros.filter { $0.recipe?.recordID == recipe.ckRecordID }.sorted { $0.macroName < $1.macroName }) { macro in
                            VStack(spacing: 2.0) {
                                Text(macro.macroUnitLabel)
                                    .tuxedoFont(.captionBold)
                                    .foregroundStyle(.foregroundPrimary)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)

                                Text(macro.macroName)
                                    .tuxedoFont(.caption)
                                    .foregroundStyle(.foregroundSecondary)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
                                    .minimumScaleFactor(0.5)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }

                    DisclosureGroup {
                        ForEach(ingredients) { ingredient in
                            HStack {
                                Text(ingredient.ingredientName)
                                Spacer()
                                Text(ingredient.ingredientUnitText)
                            }
                            .tuxedoFont(.caption)
                            .foregroundStyle(.foregroundPrimary)
                        }
                    } label: {
                        Text("Ingredients")
                    }
                    .disclosureGroupStyle(RouraDisclosureStyle())

                    DisclosureGroup {
                        ForEach(recipe.recipeInstructions.indices, id: \.self) { index in
                            Text("**Step \(index + 1):** \(recipe.recipeInstructions[index])")
                                .tuxedoFont(.caption)
                                .foregroundStyle(.foregroundPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                        }
                    } label: {
                        Text("Instructions")
                    }
                    .disclosureGroupStyle(RouraDisclosureStyle())

                    DisclosureGroup {
                        ForEach(recipeManager.nutritionalInformation.filter { $0.recipe?.recordID == recipe.ckRecordID }.sorted { $0.nutritionalInformationName < $1.nutritionalInformationName}) { nutritionalInformation in
                            HStack {
                                Text(nutritionalInformation.nutritionalInformationName)
                                Spacer()
                                Text(nutritionalInformation.nutritionalInformationUnitText)
                            }
                            .tuxedoFont(.caption)
                            .foregroundStyle(.foregroundPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                        }
                    } label: {
                        Text("Nutritional Information")
                    }
                    .disclosureGroupStyle(RouraDisclosureStyle())

                    DisclosureGroup {
                        ForEach(recipe.recipeTipsAndVariations, id: \.self) { tipAndVariation in
                            Text(tipAndVariation)
                                .tuxedoFont(.captionBold)
                                .foregroundStyle(.foregroundPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                        }
                    } label: {
                        Text("Tips and variations")
                    }
                    .disclosureGroupStyle(RouraDisclosureStyle())

                    ForEach(recipe.recipeAllergenInformation, id: \.self) { allergenInformation in
                        Text("*\(allergenInformation)")
                            .tuxedoFont(.captionExtraBold)
                            .foregroundStyle(.foregroundPrimary)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.horizontal, 16.0)
            }
        }
        .padding(.vertical, 12.0)
        .background(.backgroundPrimary)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                HStack(spacing: .zero) {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(.midnightPrimary)
                            .fontWeight(.bold)
                    }
                    .frame(width: 34, height: 50, alignment: .leading)

                    Text(recipe.recipeTitle)
                        .tuxedoFont(.h5Bold)
                        .foregroundStyle(.foregroundPrimary)
                        .minimumScaleFactor(0.5)
                }
            }

            ToolbarItem(placement: .primaryAction) {
                Button { toggleSaveState(recipe: recipe) } label: {
                    Text(saveActionTitle)
                        .tuxedoFont(.bodyBold)
                        .foregroundStyle(.midnightPrimary)
                }
            }
        }
        .task {
            viewModel.modelContext = modelContext
            viewModel.recipeManager = recipeManager
            viewModel.cloudKitManager = cloudKitManager
            await viewModel.fetchDataTaskGroup()
        }
        .overlay { if viewModel.isLoading { LoadingView() }}
        .alert($viewModel.error)
    }

    func toggleSaveState(recipe: V0_Recipe) {
        if let savedRecipeIndex = savedRecipes.firstIndex(where: { $0.recipeID == recipe.ckRecordID.recordName }) {
            viewModel.removeRecipe(savedRecipes[savedRecipeIndex])
        } else {
            viewModel.saveRecipe(recipe)
        }
    }

    var saveActionTitle: LocalizedStringResource {
        savedRecipes.contains(where: { $0.recipeID == recipe.ckRecordID.recordName }) ? "Remove" : "Save"
    }
}

#Preview {
    RecipeDetailsView(recipe: V0_Recipe(record: CKRecord(recordType: RecordType.recipe)))
        .modelContainer(for: SavedRecipe.self, inMemory: true)
}
