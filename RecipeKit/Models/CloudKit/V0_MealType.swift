//
//  V0_MealType.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/19/24.
//

import CloudKit

struct V0_MealType {
    let ckRecordID: CKRecord.ID
    let type: MealType?
}

extension V0_MealType {
    static let kType = "type"
}

extension V0_MealType {
    var recipeMealType: MealType {
        get { type ?? .none }
    }
}

extension V0_MealType: CKRecordConvertible {
    init(record: CKRecord) {
        ckRecordID = record.recordID
        type = MealType(rawValue: record[Self.kType] as? String ?? "")
    }
}

extension V0_MealType: Equatable {
    public static func ==(lhs: V0_MealType, rhs: V0_MealType) -> Bool {
        lhs.ckRecordID == rhs.ckRecordID
    }
}

extension V0_MealType: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension V0_MealType: Identifiable {
    var id: String { ckRecordID.recordName }
}
