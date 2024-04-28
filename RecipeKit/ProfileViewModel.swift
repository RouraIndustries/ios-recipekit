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

extension ProfileView {
    @Observable final class ViewModel {
        enum ProfileContext { case create, update }

        var cloudKitManager: CloudKitManager?

        var firstName = ""
        var lastName = ""

        var isLoading = false
        var avatar = PlaceholderImage.avatar
        var photosPickerItem: PhotosPickerItem? {
            didSet { loadImage() }
        }

        private var profileContext: ProfileContext = .create
        private var currentUserProfileRecord: CKRecord? {
            didSet { profileContext = .update }
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
                //                error = AlertContext.noUserRecord
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
                //                    self.error = AlertContext.unableToGetProfile
            }
        }

        func createProfile() async {
            guard let cloudKitManager else { return }

            //            guard isFormValid else {
            //                error = AlertContext.invalidProfile
            //                return
            //            }

            guard let profileRecord = modifyProfileRecord(context: .create) else { return }
            guard let userRecord = cloudKitManager.userRecord else {
                //                error = AlertContext.noUserRecord
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
                //                    error = AlertContext.createProfileSuccess
            } catch {
                hideLoadingView()
                //                    self.error = AlertContext.createProfileFailure
            }
        }

        func updateProfile() async {
            guard let cloudKitManager else { return }

            //            guard isFormValid else {
            //                error = AlertContext.invalidProfile
            //                return
            //            }

            guard let updatedProfileRecord = modifyProfileRecord(context: .update) else { return }

            showLoadingView()

            do {
                _ = try await cloudKitManager.save(record: updatedProfileRecord)
                hideLoadingView()
                //                    error = AlertContext.updateProfileSuccess
            } catch {
                hideLoadingView()
                //                    self.error = AlertContext.updateProfileFailure
            }
        }

        private func modifyProfileRecord(context: ProfileContext) -> CKRecord? {
            var profileRecord: CKRecord

            switch context {
            case .create:
                profileRecord = CKRecord(recordType: RecordType.profile)

            case .update:
                guard let currentUserProfileRecord else {
                    //                    error = AlertContext.unableToGetProfile
                    return nil
                }

                profileRecord = currentUserProfileRecord
            }

            profileRecord[V0_Profile.kFirstName] = firstName
            profileRecord[V0_Profile.kLastName] = lastName
            profileRecord[V0_Profile.kAvatarAsset] = avatar.convertToCKAsset()

            return profileRecord
        }

        private func setProfileData(from record: CKRecord) {
            let profile = V0_Profile(record: record)
            firstName = profile.profileFirstName
            lastName = profile.profileLastName
            avatar = profile.profileImage
        }

        private func loadImage() {
            Task {
                if let loadedImage = try? await photosPickerItem?.loadTransferable(type: Data.self) {
                    avatar = UIImage(data: loadedImage) ?? PlaceholderImage.avatar
                } else {
                    //                    Log.info("Failed")
                }
            }
        }

        private func showLoadingView() { Task { @MainActor in isLoading = true }}
        private func hideLoadingView() { Task { @MainActor in isLoading = false }}
    }
}
