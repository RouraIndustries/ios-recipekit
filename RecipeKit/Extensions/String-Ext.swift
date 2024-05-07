//
//  String-Ext.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 5/4/24.
//

import Foundation

extension String {
    var unitIdentifier: UnitIdentifier? {
        switch self.lowercased() {
        case "grams": return .grams
        case "milligrams": return .milligrams

        case "cups": return .cups
        case "teaspoons": return .teaspoon
        case "tablespoons": return .tablespoon
        case "milliliters": return .milliliters

        case "calories": return .calories

        default: return nil
        }
    }
}
