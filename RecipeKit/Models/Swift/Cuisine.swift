//
//  Cuisine.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/25/24.
//

import Foundation

enum Cuisine: String, CaseIterable {
    case american = "American"
    case mediterranean = "Mediterranean"
    case puertoRican = "Puerto Rican"
    case none
}

extension Cuisine: Identifiable {
    var id: String { rawValue }
}
