//
//  V0_Stat.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/19/24.
//

import CloudKit

struct V0_Stat {
    let ckRecordID: CKRecord.ID
    let name: String?
    let quantity: Double?
    let unit: String?
    let recipe: CKRecord.Reference?
}

extension V0_Stat {
    static let kName = "name"
    static let kQuantity = "quantity"
    static let kUnit = "unit"
    static let kRecipe = "recipe"
}

extension V0_Stat {
    var statName: String {
        get { name ?? "" }
    }

    var statUnitLabel: String {
        get { "\(Int(quantity?.rounded() ?? 0)) \(unit ?? "")" }
    }
}

extension V0_Stat: CKRecordConvertible {
    init(record: CKRecord) {
        ckRecordID = record.recordID
        name = record[Self.kName] as? String ?? ""
        quantity = record[Self.kQuantity] as? Double ?? 0
        unit = record[Self.kUnit] as? String ?? ""
        recipe = record[Self.kRecipe] as? CKRecord.Reference
    }
}

extension V0_Stat: Equatable {
    public static func ==(lhs: V0_Stat, rhs: V0_Stat) -> Bool {
        lhs.ckRecordID == rhs.ckRecordID
    }
}

extension V0_Stat: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension V0_Stat: Identifiable {
    var id: String { ckRecordID.recordName }
}
