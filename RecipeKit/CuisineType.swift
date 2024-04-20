//
//  CuisineType.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/18/24.
//

import Foundation
import SwiftData

@Model
final class CuisineType {
    var type: String = ""

    var recipes: [Recipe]?

    init(type: String) {
        self.type = type
    }
}
