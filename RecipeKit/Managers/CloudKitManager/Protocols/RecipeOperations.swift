//
//  RecipeOperations.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/26/24.
//

import CloudKit

protocol RecipeOperations {
    func getRecipes() async throws -> [V0_Recipe]
    func getIngredients(for recipe: V0_Recipe) async throws -> [V0_Ingredient]
    func getMacros(for recipe: V0_Recipe) async throws -> [V0_Macro]
    func getNutritionalInformation(for recipe: V0_Recipe) async throws -> [V0_NutritionalInformation]
    func getStats(for recipe: V0_Recipe) async throws -> [V0_Stat]
}
