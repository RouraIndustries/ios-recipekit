//
//  V0_Profile.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/19/24.
//

import CloudKit
import SwiftUI

// MARK: - V0_Profile model

struct V0_Profile {
    let ckRecordID: CKRecord.ID
    var firstName: String?
    var lastName: String?
    var username: String?
    var bio: String?
    var avatarAsset: CKAsset?
    var joinedOnDate: Date?
}

// MARK: - RKProfile - constants

extension V0_Profile {
    static let kFirstName = "firstName"
    static let kLastName = "lastName"
    static let kUsername = "username"
    static let kBio = "bio"
    static let kAvatarAsset = "avatarAsset"
    static let kJoinedOnDate = "joinedOnDate"
}

// MARK: - V0_Profile - helpers

extension V0_Profile {
    var identifier: String {
        get { ckRecordID.recordName }
    }

    var profileFirstName: String {
        get { firstName ?? "" }
        set { firstName = newValue }
    }

    var profileLastName: String {
        get { lastName ?? "" }
        set { lastName = newValue }
    }

    var profileUsername: String {
        get { username ?? "" }
        set { username = newValue }
    }

    var profileBio: String {
        get { bio ?? "" }
        set { bio = newValue }
    }

    var profileJoinedOnDate: Date {
        get { joinedOnDate ?? .now }
    }
}

// MARK: - V0_Profile - initializer

extension V0_Profile {
    init(record: CKRecord) {
        ckRecordID = record.recordID
        firstName = record[Self.kFirstName] as? String ?? "No first name"
        lastName = record[Self.kLastName] as? String ?? "No last name"
        username = record[Self.kUsername] as? String ?? "No username"
        bio = record[Self.kBio] as? String ?? "No bio"
        avatarAsset = record[Self.kAvatarAsset] as? CKAsset
        joinedOnDate = record[Self.kJoinedOnDate] as? Date ?? Date.now
    }
}
