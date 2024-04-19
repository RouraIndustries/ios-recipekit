//
//  Profile.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/19/24.
//

import CloudKit
import SwiftUI

// MARK: - Profile model

struct Profile {
    let ckRecordID: CKRecord.ID
    var firstName: String?
    var lastName: String?
    var company: String?
    var bio: String?
    var avatarAsset: CKAsset?
    var joinedOnDate: Date?
}

// MARK: - RKProfile - helpers

extension Profile {
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

    var profileCompany: String {
        get { company ?? "" }
        set { company = newValue }
    }

    var profileBio: String {
        get { bio ?? "" }
        set { bio = newValue }
    }

    var profileJoinedOnDate: Date {
        get { joinedOnDate ?? .now }
    }
}

// MARK: - Profile - constants

extension Profile {
    static let kFirstName = "firstName"
    static let kLastName = "lastName"
    static let kCompany = "company"
    static let kBio = "bio"
    static let kAvatarAsset = "avatarAsset"
    static let kJoinedOnDate = "joinedOnDate"
}

// MARK: - Profile - initializer

extension Profile {
    init(record: CKRecord) {
        ckRecordID = record.recordID
        firstName = record[Self.kFirstName] as? String ?? "No first name"
        lastName = record[Self.kLastName] as? String ?? "No last name"
        company = record[Self.kCompany] as? String ?? "No company"
        bio = record[Self.kBio] as? String ?? "No bio"
        avatarAsset = record[Self.kAvatarAsset] as? CKAsset
        joinedOnDate = record[Self.kJoinedOnDate] as? Date ?? Date.now
    }
}