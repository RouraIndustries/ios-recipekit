//
//  UnitConverterUtil.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 5/4/24.
//

import SwiftUI

struct UnitConverterUtil {
    static func unit(from identifier: UnitIdentifier) -> Unit {
        switch identifier {
        case .grams: return UnitMass.grams
        case .milligrams: return UnitMass.milligrams

        case .cups: return UnitVolume.cups
        case .teaspoon: return UnitVolume.teaspoons
        case .tablespoon: return UnitVolume.tablespoons
        case .milliliters: return UnitVolume.milliliters

        case .calories: return UnitEnergy.calories
        }
    }
}
