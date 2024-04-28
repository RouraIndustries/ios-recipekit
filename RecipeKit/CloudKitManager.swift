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

// MARK: - CloudKitManager-CategoryOperations

extension CloudKitManager: CategoryOperations {
    @MainActor
    func getCuisineTypes() async throws -> [V0_CuisineType] {
        //        Log.info("✅ Network call fired off")

        let alphabeticalSortDescriptor = NSSortDescriptor(key: V0_CuisineType.kType, ascending: true)
        let query = CKQuery(recordType: RecordType.category, predicate: NSPredicate(value: true))

        do {
            return try await fetchRecords(with: query, sortDescriptors: [alphabeticalSortDescriptor])
        } catch {
            throw error
        }
    }

    @MainActor
    func getMealTypes() async throws -> [V0_MealType] {
        //        Log.info("✅ Network call fired off")

        let alphabeticalSortDescriptor = NSSortDescriptor(key: V0_MealType.kType, ascending: true)
        let query = CKQuery(recordType: RecordType.mealType, predicate: NSPredicate(value: true))

        do {
            return try await fetchRecords(with: query, sortDescriptors: [alphabeticalSortDescriptor])
        } catch {
            throw error
        }
    }

    @MainActor
    func getMacros() async throws -> [V0_Macro] {
        //        Log.info("✅ Network call fired off")

        let alphabeticalSortDescriptor = NSSortDescriptor(key: V0_Macro.kName, ascending: true)
        let query = CKQuery(recordType: RecordType.macro, predicate: NSPredicate(value: true))

        do {
            return try await fetchRecords(with: query, sortDescriptors: [alphabeticalSortDescriptor])
        } catch {
            throw error
        }
    }

    @MainActor
    func getIngredients() async throws -> [V0_Ingredient] {
        //        Log.info("✅ Network call fired off")

        let alphabeticalSortDescriptor = NSSortDescriptor(key: V0_Ingredient.kName, ascending: true)
        let query = CKQuery(recordType: RecordType.ingredient, predicate: NSPredicate(value: true))

        do {
            return try await fetchRecords(with: query, sortDescriptors: [alphabeticalSortDescriptor])
        } catch {
            throw error
        }
    }
}

// MARK: - CloudKitManager-RecipeOperations

extension CloudKitManager: RecipeOperations {
    @MainActor
    func getRecipes() async throws -> [V0_Recipe] {
        //        Log.info("✅ Network call fired off")

        let alphabeticalSortDescriptor = NSSortDescriptor(key: V0_Recipe.kTitle, ascending: true)
        let query = CKQuery(recordType: RecordType.recipe, predicate: NSPredicate(value: true))

        do {
            return try await fetchRecords(with: query, sortDescriptors: [alphabeticalSortDescriptor])
        } catch {
            throw error
        }
    }

    @MainActor
    func getIngredients(for recipe: V0_Recipe) async throws -> [V0_Ingredient] {
        //        Log.info("✅ Network call fired off")

        let alphabeticalSortDescriptor = NSSortDescriptor(key: V0_Ingredient.kName, ascending: true)
        let predicate = NSPredicate(format: "recipe == %@", recipe.ckRecordID)
        let query = CKQuery(recordType: RecordType.ingredient, predicate: predicate)

        do {
            return try await fetchRecords(with: query, sortDescriptors: [alphabeticalSortDescriptor])
        } catch {
            throw error
        }
    }

    @MainActor
    func getMacros(for recipe: V0_Recipe) async throws -> [V0_Macro] {
        //        Log.info("✅ Network call fired off")

        let alphabeticalSortDescriptor = NSSortDescriptor(key: V0_Macro.kName, ascending: true)
        let predicate = NSPredicate(format: "recipe == %@", recipe.ckRecordID)
        let query = CKQuery(recordType: RecordType.macro, predicate: predicate)

        do {
            return try await fetchRecords(with: query, sortDescriptors: [alphabeticalSortDescriptor])
        } catch {
            throw error
        }
    }

    @MainActor
    func getNutritionalInformation(for recipe: V0_Recipe) async throws -> [V0_NutritionalInformation] {
        //        Log.info("✅ Network call fired off")

        let alphabeticalSortDescriptor = NSSortDescriptor(key: V0_NutritionalInformation.kName, ascending: true)
        let predicate = NSPredicate(format: "recipe == %@", recipe.ckRecordID)
        let query = CKQuery(recordType: RecordType.nutritionalInformation, predicate: predicate)

        do {
            return try await fetchRecords(with: query, sortDescriptors: [alphabeticalSortDescriptor])
        } catch {
            throw error
        }
    }

    @MainActor
    /// This function `getStats` takes in a recipe and will provide the stat information including the preparation time, cook time and serving size.
    /// - Parameter recipe: This is the parameter of type RKRecipe which is a recipe within RecipeKit.
    /// - Returns: Will provide an array of `RKStat` which will include detailed statistics about the recipe.
    func getStats(for recipe: V0_Recipe) async throws -> [V0_Stat] {
        //        Log.info("✅ Network call fired off")

        let alphabeticalSortDescriptor = NSSortDescriptor(key: V0_Stat.kName, ascending: true)
        let predicate = NSPredicate(format: "recipe == %@", recipe.ckRecordID)
        let query = CKQuery(recordType: RecordType.stat, predicate: predicate)

        do {
            return try await fetchRecords(with: query, sortDescriptors: [alphabeticalSortDescriptor])
        } catch {
            throw error
        }
    }
}
