//
//  Category.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/18/24.
//

import Foundation
import SwiftData

@Model
final class Category {
    var type: String

    init(type: String) {
        self.type = type
    }
}
