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
    let metricQuantity: Double?
    let metricUnit: String?
    let recipe: CKRecord.Reference?
}

extension V0_Ingredient {
    static let kName = "name"
    static let kQuantity = "quantity"
    static let kUnit = "unit"
    static let kMetricQuantity = "metricQuantity"
    static let kMetricUnit = "metricUnit"
    static let kRecipe = "recipe"
}

extension V0_Ingredient {
    var ingredientName: String {
        get { name ?? "" }
    }

    var ingredientUnitText: String {
        get { MeasurementFormatterUtil.formatMeasurement(from: quantity, unit: unit, metricQuantity: metricQuantity, metricUnit: metricUnit) }
    }
}

extension V0_Ingredient: CKRecordConvertible {
    init(record: CKRecord) {
        ckRecordID = record.recordID
        name = record[Self.kName] as? String ?? ""
        quantity = record[Self.kQuantity] as? Double ?? 0
        unit = record[Self.kUnit] as? String ?? ""
        metricQuantity = record[Self.kMetricQuantity] as? Double ?? 0
        metricUnit = record[Self.kMetricUnit] as? String ?? ""
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
