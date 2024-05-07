//
//  SavedRecipesViewModel.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/28/24.
//

import Foundation
import SwiftData

extension SavedRecipesView {
    @Observable final class ViewModel {
        var recipeManager: RecipeManager?
        var cloudKitManager: CloudKitManager?
        
        var isLoading = false
        var showError = false
        var error: AlertItem? {
            didSet { showError.toggle() }
        }
        
        func fetchDataTaskGroup() async {
            guard let recipeManager, let cloudKitManager else { return }
            showLoadingView()

            async let cuisineTypes = cloudKitManager.getCuisineTypes()
            async let recipes = cloudKitManager.getRecipes()
            async let mealTypes = cloudKitManager.getMealTypes()
            async let macros = cloudKitManager.getMacros()

            do {
                let (cuisineTypesResult, recipesResult, mealTypesResult, macrosResult) =
                try await (cuisineTypes, recipes, mealTypes, macros)

                recipeManager.cuisineTypes = cuisineTypesResult
                recipeManager.recipes = recipesResult
                recipeManager.mealTypes = mealTypesResult
                recipeManager.macros = macrosResult

                hideLoadingView()
            } catch {
                hideLoadingView()
                                self.error = AlertContext.unableToFetchData
            }
        }

        private func showLoadingView() { Task { @MainActor in isLoading = true }}
        private func hideLoadingView() { Task { @MainActor in isLoading = false }}
    }
}
