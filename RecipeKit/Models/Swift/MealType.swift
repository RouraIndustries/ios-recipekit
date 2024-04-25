//
//  MealType.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/25/24.
//

import Foundation

enum MealType: String, CaseIterable {
    case breakfast = "Breakfast"
    case side = "Side"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case drink = "Drink"

    case none
}

extension MealType: Identifiable {
    var id: String { rawValue }
}
