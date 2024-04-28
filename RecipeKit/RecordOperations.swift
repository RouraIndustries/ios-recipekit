//
//  RecordOperations.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/26/24.
//

import CloudKit

protocol RecordOperations {
    func batchSave(records: [CKRecord]) async throws -> [CKRecord]
    func save(record: CKRecord) async throws -> CKRecord
    func fetchRecord(with id: CKRecord.ID) async throws -> CKRecord
}
