//
//  RecipeDetailsViewModel.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/27/24.
//

import Foundation
import SwiftData

extension RecipeDetailsView {
    @Observable final class ViewModel: ObservableObject {
        var recipeManager: RecipeManager?
        var cloudKitManager: CloudKitManager?

        var isLoading = false
        
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
//                self.error = AlertContext.unableToFetchData
            }
        }

        private func showLoadingView() { Task { @MainActor in isLoading = true }}
        private func hideLoadingView() { Task { @MainActor in isLoading = false }}
    }
}
