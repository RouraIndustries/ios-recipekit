//
//  AlertItem.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 5/3/24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Text
}

struct AlertContext {
    // MARK: - RecipeListView errors

    static let unableToFetchData = AlertItem(
        title: Text("Unable to Retrieve Data"),
        message: Text("We couldn't fetch data at this time. Please try again later."),
        dismissButton: Text("OK")
    )

    // MARK: - ProfileView errors

    static let invalidProfile = AlertItem(
        title: Text("Invalid Profile"),
        message: Text("All fields are required. Your bio must be 120 characters or less. Please try again."),
        dismissButton: Text("OK")
    )

    static let unableToGetProfile = AlertItem(
        title: Text("Unable to Retrieve Profile"),
        message: Text("We couldn't retrieve your profile at this time. Please check your internet connection and try again later."),
        dismissButton: Text("OK")
    )

    static let createProfileSuccess = AlertItem(
        title: Text("Profile Created Successfully"),
        message: Text("Your profile has been created successfully."),
        dismissButton: Text("OK")
    )

    static let createProfileFailure = AlertItem(
        title: Text("Unable to Create Profile"),
        message: Text("We couldn't create your profile at this time. Please try again later."),
        dismissButton: Text("OK")
    )

    static let updateProfileSuccess = AlertItem(
        title: Text("Profile Updated Successfully"),
        message: Text("Your profile has been updated successfully."),
        dismissButton: Text("OK")
    )

    static let updateProfileFailure = AlertItem(
        title: Text("Unable to Update Profile"),
        message: Text("We couldn't update your profile at this time. Please try again later."),
        dismissButton: Text("OK")
    )

    // MARK: - CloudKitManager errors

    static let noUserRecord = AlertItem(
        title: Text("No User Record Found"),
        message: Text("You must log into iCloud on your phone to use RecipeKit. Please sign into iCloud through Settings > iCloud. Please note that if you save recipes without an iCloud account, they will not be synced across your devices."),
        dismissButton: Text("OK")
    )

    // MARK: - SavedRecipesView errors
    
    static let savedRecipeSuccess = AlertItem(
        title: Text("Recipe Saved"),
        message: Text("The recipe has been saved successfully."),
        dismissButton: Text("OK")
    )

    static let savedRecipeFailure = AlertItem(
        title: Text("Failed to Save Recipe"),
        message: Text("We couldn't save the recipe at this time.\nPlease try again later."),
        dismissButton: Text("OK")
    )

    static let removeRecipeSuccess = AlertItem(
        title: Text("Recipe Removed"),
        message: Text("The recipe has been removed successfully."),
        dismissButton: Text("OK")
    )

    static let removeRecipeFailure = AlertItem(
        title: Text("Failed to Remove Recipe"),
        message: Text("We couldn't remove the recipe.\nPlease try again."),
        dismissButton: Text("Ok")
    )
}
