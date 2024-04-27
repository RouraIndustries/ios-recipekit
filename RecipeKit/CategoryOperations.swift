//
//  CategoryOperations.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/26/24.
//

import CloudKit

protocol CategoryOperations {
    func getCuisineTypes() async throws -> [V0_CuisineType]
    func getMealTypes() async throws -> [V0_MealType]
    func getMacros() async throws -> [V0_Macro]
    func getIngredients() async throws -> [V0_Ingredient]
}
