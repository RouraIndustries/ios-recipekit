//
//  ProfileViewModel.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/26/24.
//

import CloudKit
import Observation
import UIKit
import PhotosUI
import SwiftUI
import RouraFoundation

extension ProfileView {
    @Observable final class ViewModel {
        enum ProfileContext { case create, update }

        var cloudKitManager: CloudKitManager?

        var firstName = ""
        var lastName = ""
        var username = ""
        var bio = ""
        var joinedOnDate: Date = Date.now
        var avatar = PlaceholderImage.avatar
        var photosPickerItem: PhotosPickerItem? {
            didSet { loadImage() }
        }

        var showSettingsView = false
        var isLoading = false
        var showError = false
        var error: AlertItem? {
            didSet { showError.toggle() }
        }

        private let bioMaxCharacterLimit = 120
        private var profileContext: ProfileContext = .create
        private var currentUserProfileRecord: CKRecord? {
            didSet { profileContext = .update }
        }

        var isFormValid: Bool {
            guard
                firstName.isEmpty == false,
                lastName.isEmpty == false,
                username.isEmpty == false,
                bio.isEmpty == false,
                charactersRemainCount >= 0
            else { return false }

            return true
        }

        var charactersRemainCount: Int {
            bioMaxCharacterLimit - bio.trimmingCharacters(in: .whitespacesAndNewlines).count
        }

        var bioWithinCountThresholdColor: Color {
            charactersRemainCount > 0 ? .greenPrimary : .redPrimary
        }

        var buttonTitle: LocalizedStringResource {
            profileContext == .create ? "Create profile" : "Update profile"
        }

        func buttonAction() {
            Task { @MainActor in profileContext == .create ? await createProfile() : await updateProfile() }
        }

        func fetchProfile() async {
            guard let cloudKitManager else { return }

            if cloudKitManager.userRecord == nil {
                try? await cloudKitManager.getUserRecord()
            }

            guard let userRecord = cloudKitManager.userRecord else {
                                error = AlertContext.noUserRecord
                return
            }

            guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else {
                return
            }

            let profileRecordID = profileReference.recordID

            showLoadingView()

            do {
                let profileRecord = try await cloudKitManager.fetchRecord(with: profileRecordID)
                currentUserProfileRecord = profileRecord
                setProfileData(from: profileRecord)
                hideLoadingView()
            } catch {
                hideLoadingView()
                                    self.error = AlertContext.unableToGetProfile
            }
        }

        func createProfile() async {
            guard let cloudKitManager else { return }

                        guard isFormValid else {
                            error = AlertContext.invalidProfile
                            return
                        }

            guard let profileRecord = modifyProfileRecord(context: .create) else { return }
            guard let userRecord = cloudKitManager.userRecord else {
                                error = AlertContext.noUserRecord
                return
            }

            userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)

            showLoadingView()

            do {
                let records = try await cloudKitManager.batchSave(records: [ userRecord, profileRecord ])

                for record in records where record.recordType == RecordType.profile {
                    currentUserProfileRecord = record
                    cloudKitManager.profileRecordID = record.recordID
                }

                hideLoadingView()
                                    error = AlertContext.createProfileSuccess
            } catch {
                hideLoadingView()
                                    self.error = AlertContext.createProfileFailure
            }
        }

        func updateProfile() async {
            guard let cloudKitManager else { return }

                        guard isFormValid else {
                            error = AlertContext.invalidProfile
                            return
                        }

            guard let updatedProfileRecord = modifyProfileRecord(context: .update) else { return }

            showLoadingView()

            do {
                _ = try await cloudKitManager.save(record: updatedProfileRecord)
                hideLoadingView()
                                    error = AlertContext.updateProfileSuccess
            } catch {
                hideLoadingView()
                                    self.error = AlertContext.updateProfileFailure
            }
        }

        private func modifyProfileRecord(context: ProfileContext) -> CKRecord? {
            var profileRecord: CKRecord

            switch context {
            case .create:
                profileRecord = CKRecord(recordType: RecordType.profile)

            case .update:
                guard let currentUserProfileRecord else {
                                        error = AlertContext.unableToGetProfile
                    return nil
                }

                profileRecord = currentUserProfileRecord
            }

            profileRecord[V0_Profile.kFirstName] = firstName
            profileRecord[V0_Profile.kLastName] = lastName
            profileRecord[V0_Profile.kAvatarAsset] = avatar.convertToCKAsset()
            profileRecord[V0_Profile.kUsername] = username
            profileRecord[V0_Profile.kBio] = bio
            profileRecord[V0_Profile.kJoinedOnDate] = joinedOnDate

            return profileRecord
        }

        private func setProfileData(from record: CKRecord) {
            let profile = V0_Profile(record: record)
            firstName = profile.profileFirstName
            lastName = profile.profileLastName
            avatar = profile.profileImage
            username = profile.profileUsername
            bio = profile.profileBio
            joinedOnDate = profile.profileJoinedOnDate
        }

        private func loadImage() {
            Task {
                if let loadedImage = try? await photosPickerItem?.loadTransferable(type: Data.self) {
                    avatar = UIImage(data: loadedImage) ?? PlaceholderImage.avatar
                } else {
                                        Log.info("Failed")
                }
            }
        }

        private func showLoadingView() { Task { @MainActor in isLoading = true }}
        private func hideLoadingView() { Task { @MainActor in isLoading = false }}
    }
}
