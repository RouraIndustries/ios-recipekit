//
//  RecipeExploreViewModel.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/26/24.
//

import CloudKit
import SwiftUI
import Observation

extension RecipeExploreView {
    @Observable final class ViewModel {
        var recipeManager: RecipeManager?
        var cloudKitManager: CloudKitManager?

        var isLoading = false

        func recipesForCuisineType(_ cuisineType: V0_CuisineType) -> [V0_Recipe] {
            guard let recipeManager else { return [] }

            return recipeManager.recipes
                .filter { $0.cuisineType?.recordID == cuisineType.ckRecordID }
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
                //                self.error = AlertContext.unableToFetchData
            }
        }

        private func showLoadingView() { Task { @MainActor in isLoading = true }}
        private func hideLoadingView() { Task { @MainActor in isLoading = false }}
    }
}
