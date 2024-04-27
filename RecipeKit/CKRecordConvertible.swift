//
//  CKRecordConvertible.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/27/24.
//

import CloudKit

protocol CKRecordConvertible {
    init(record: CKRecord)
}
