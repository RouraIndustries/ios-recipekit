//
//  CloudKitManager.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/25/24.
//

import CloudKit
import Observation
import SwiftUI

@Observable final class CloudKitManager {
    var userRecord: CKRecord?
    var profileRecordID: CKRecord.ID?

    private let container = CKContainer.default()
    private let resultsLimit = 25

    init() {
        Task { await fetchUserRecord() }
    }

    func fetchUserRecord() async {
        try? await getUserRecord()
    }
}

// MARK: - CloudKitManager-UserOperations

extension CloudKitManager: UserOperations {
    @MainActor
    func getUserRecord() async throws {
        do {
            let recordID = try await container.userRecordID()
            let record = try await container.publicCloudDatabase.record(for: recordID)
            userRecord = record

            guard let profileReference = record["userProfile"] as? CKRecord.Reference else { return }
            profileRecordID = profileReference.recordID
        } catch {
            throw error
        }
    }
}

// MARK: - CloudKitManager-RecordOperations

extension CloudKitManager: RecordOperations {
    @MainActor
    func batchSave(records: [CKRecord]) async throws -> [CKRecord] {
        do {
            let (savedResults, _) = try await container.publicCloudDatabase.modifyRecords(saving: records, deleting: [])
            let savedRecords = savedResults.compactMap { try? $1.get() }

            return savedRecords
        } catch {
            throw error
        }
    }

    @MainActor
    func save(record: CKRecord) async throws -> CKRecord {
        do {
            return try await container.publicCloudDatabase.save(record)
        } catch {
            throw error
        }
    }

    @MainActor
    func fetchRecord(with id: CKRecord.ID) async throws -> CKRecord {
        do {
            return try await container.publicCloudDatabase.record(for: id)
        } catch {
            throw error
        }
    }
}
