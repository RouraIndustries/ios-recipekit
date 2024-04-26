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
        let recordID = try await container.userRecordID()
        let record = try await container.publicCloudDatabase.record(for: recordID)
        userRecord = record

        guard let profileReference = record["userProfile"] as? CKRecord.Reference else { return }
        profileRecordID = profileReference.recordID
    }
}
