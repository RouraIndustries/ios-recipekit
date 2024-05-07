//
//  RecipeDetailsViewModel.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/27/24.
//

import Foundation
import SwiftData

extension RecipeDetailsView {
    @Observable final class ViewModel {
        var modelContext: ModelContext?
        var recipeManager: RecipeManager?
        var cloudKitManager: CloudKitManager?

        var isLoading = false
        var showError = false
        var error: AlertItem? {
            didSet { showError.toggle() }
        }

        private let recipe: V0_Recipe

        init(recipe: V0_Recipe) {
            self.recipe = recipe
        }

        var mealType: String {
            guard let recipeManager else { return "" }

            return recipeManager.mealTypes
                .first { $0.ckRecordID == recipe.mealType?.recordID }?
                .recipeMealType.rawValue ?? ""
        }

        func fetchDataTaskGroup() async {
            guard let recipeManager, let cloudKitManager else { return }
            showLoadingView()

            async let ingredients = cloudKitManager.getIngredients(for: recipe)
            async let macros = cloudKitManager.getMacros(for: recipe)
            async let nutritionalInformation = cloudKitManager.getNutritionalInformation(for: recipe)
            async let stats = cloudKitManager.getStats(for: recipe)

            do {
                let (ingredientsResult, macrosResult, nutritionalInformationResult, statsResult) =
                try await (ingredients, macros, nutritionalInformation, stats)

                recipeManager.ingredients = ingredientsResult
                recipeManager.macros = macrosResult
                recipeManager.nutritionalInformation = nutritionalInformationResult
                recipeManager.stats = statsResult

                hideLoadingView()
            } catch {
                hideLoadingView()
                                self.error = AlertContext.unableToFetchData
            }
        }

        func saveRecipe(_ recipe: V0_Recipe) {
            showLoadingView()

            let savedRecipe = SavedRecipe(recipeID: recipe.ckRecordID.recordName)
            modelContext?.insert(savedRecipe)

            do {
                try modelContext?.save()
                hideLoadingView()
                error = AlertContext.savedRecipeSuccess
            } catch {
                hideLoadingView()
                self.error = AlertContext.savedRecipeFailure
            }
        }

        func removeRecipe(_ recipe: SavedRecipe) {
            showLoadingView()

            modelContext?.delete(recipe)

            do {
                try modelContext?.save()
                hideLoadingView()
                error = AlertContext.removeRecipeSuccess
            } catch {
                hideLoadingView()
                self.error = AlertContext.removeRecipeSuccess
            }
        }

        private func showLoadingView() { Task { @MainActor in isLoading = true }}
        private func hideLoadingView() { Task { @MainActor in isLoading = false }}
    }
}
