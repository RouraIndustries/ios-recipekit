//
//  RecipeManagerEnvironmentKey.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/26/24.
//

import CloudKit

private struct RecipeManagerEnvironmentKey: EnvironmentKey {
    static var defaultValue = RecipeManager()
}

extension EnvironmentValues {
    var recipeManager: RecipeManager {
        get { self[RecipeManagerEnvironmentKey.self] }
        set { self[RecipeManagerEnvironmentKey.self] = newValue }
    }
}
