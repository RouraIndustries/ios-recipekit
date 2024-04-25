//
//  Macro.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/25/24.
//

import Foundation

enum Macro: String, CaseIterable {
    case calories = "Calories"
    case carbs = "Carbs"
    case fat = "Fat"
    case protein = "Protein"

    var abbreviation: String {
        switch self {
        case .calories: return "Cals"
        case .carbs: return "Carbs"
        case .fat: return "Fat"
        case .protein: return "Pro"
        }
    }
}

extension Macro: Identifiable {
    var id: String { rawValue }
}
