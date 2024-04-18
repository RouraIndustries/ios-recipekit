//
//  RecipeKitApp.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/17/24.
//

import SwiftUI
import SwiftData

@main
struct Portfolio_SwiftDataApp: App {
    // MARK: - Properties

    // The sharedModelContainer is the main container for SwiftData.
    // It holds the schema and configurations necessary for managing data.
    var sharedModelContainer: ModelContainer = {
        // Define the schema for the data, which includes the Issue model. This is a PersistentModel.
        let schema = Schema([ Recipe.self ])

        // Create a model configuration specifying the schema.
        let modelConfiguration = ModelConfiguration(schema: schema)

        // Initialize the ModelContainer with the schema and configurations.
        do {
            return try ModelContainer(for: schema, configurations: [ modelConfiguration ])
        } catch {
            // If there's an error creating the ModelContainer, terminate the app.
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        // Define the main scene of the app.
        WindowGroup {
            // ContentView is the entry point of the app's user interface.
            ContentView()
        }
        // Attach the sharedModelContainer to the scene.
        .modelContainer(sharedModelContainer)
    }

    init() {
        // Print the URL location for the SQLite database created by SwiftData.
        // This directory typically holds the application's support files.
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
