//
//  V0_Ingredient.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/18/24.
//

import CloudKit
import SwiftUI

struct V0_Ingredient {
    let ckRecordID: CKRecord.ID
    let name: String?
    let quantity: Double?
    let unit: String?
    let recipe: CKRecord.Reference?
}

extension V0_Ingredient {
    static let kName = "name"
    static let kQuantity = "quantity"
    static let kUnit = "unit"
    static let kRecipe = "recipe"
}

extension V0_Ingredient {
    var ingredientName: String {
        get { name ?? "" }
    }

    var ingredientUnitText: Text {
        get { Text(quantity ?? 1, format: .number) + Text(" ") + Text(unit ?? "") }
    }
}

extension V0_Ingredient {
    init(record: CKRecord) {
        ckRecordID = record.recordID
        name = record[Self.kName] as? String ?? ""
        quantity = record[Self.kQuantity] as? Double ?? 1
        unit = record[Self.kUnit] as? String ?? ""
        recipe = record[Self.kRecipe] as? CKRecord.Reference
    }
}

extension V0_Ingredient: Equatable {
    public static func ==(lhs: V0_Ingredient, rhs: V0_Ingredient) -> Bool {
        lhs.ckRecordID == rhs.ckRecordID
    }
}

extension V0_Ingredient: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension V0_Ingredient: Identifiable {
    var id: String { ckRecordID.recordName }
}
