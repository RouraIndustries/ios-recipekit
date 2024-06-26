//
//  V0_Macro.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/19/24.
//

import CloudKit

struct V0_Macro {
    let ckRecordID: CKRecord.ID
    let name: String?
    let quantity: Double?
    let unit: String?
    let metricQuantity: Double?
    let metricUnit: String?
    let recipe: CKRecord.Reference?
}

extension V0_Macro {
    static let kName = "name"
    static let kQuantity = "quantity"
    static let kUnit = "unit"
    static let kMetricQuantity = "metricQuantity"
    static let kMetricUnit = "metricUnit"
    static let kRecipe = "recipe"
}

extension V0_Macro {
    var macroName: String {
        get { name ?? "" }
    }

    var macroUnitLabel: String {
        get { MeasurementFormatterUtil.formatMeasurement(from: quantity, unit: unit, metricQuantity: metricQuantity, metricUnit: metricUnit) }
    }
}

extension V0_Macro: CKRecordConvertible {
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

extension V0_Macro: Equatable {
    public static func ==(lhs: V0_Macro, rhs: V0_Macro) -> Bool {
        lhs.ckRecordID == rhs.ckRecordID
    }
}

extension V0_Macro: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension V0_Macro: Identifiable {
    var id: String { ckRecordID.recordName }
}
