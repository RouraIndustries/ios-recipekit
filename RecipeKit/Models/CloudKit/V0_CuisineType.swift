//
//  V0_CuisineType.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/18/24.
//

import CloudKit

struct V0_CuisineType {
    let ckRecordID: CKRecord.ID
    let type: Cuisine?
}

extension V0_CuisineType {
    static let kType = "type"
}

extension V0_CuisineType {
    var categoryType: Cuisine {
        get { type ?? .none }
    }
}

extension V0_CuisineType {
    init(record: CKRecord) {
        ckRecordID = record.recordID
        type = Cuisine(rawValue: record[Self.kType] as? String ?? "")
    }
}

extension V0_CuisineType: Equatable {
    public static func ==(lhs: V0_CuisineType, rhs: V0_CuisineType) -> Bool {
        lhs.ckRecordID == rhs.ckRecordID
    }
}

extension V0_CuisineType: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension V0_CuisineType: Identifiable {
    var id: String { ckRecordID.recordName }
}
