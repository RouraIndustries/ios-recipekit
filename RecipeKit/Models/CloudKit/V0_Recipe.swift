//
//  V0_Recipe.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/18/24.
//

import CloudKit
import SwiftUI

struct V0_Recipe {
    let ckRecordID: CKRecord.ID
    let title: String?
    let content: String?
    let instructions: [String]?
    let allergenInformation: [String]?
    let tipsAndVariations: [String]?
    let squareAsset: CKAsset?
    let bannerAsset: CKAsset?
    let category: CKRecord.Reference?
    let mealType: CKRecord.Reference?
    let stat: CKRecord.Reference?
    let ingredient: CKRecord.Reference?
}

extension V0_Recipe {
    static let kTitle = "title"
    static let kContent = "content"
    static let kInstructions = "instructions"
    static let kAllergenInformation = "allergenInformation"
    static let kTipsAndVariations = "tipsAndVariations"
    static let kSquareAsset = "squareAsset"
    static let kBannerAsset = "bannerAsset"

    static let kCategory = "category"
    static let kMealType = "mealType"
    static let kStat = "stat"
    static let kIngredient = "ingredient"
}

extension V0_Recipe {
    var recipeTitle: String {
        get { title ?? "" }
    }

    var recipeContent: String {
        get { content ?? "" }
    }

    var recipeInstructions: [String] {
        get { instructions ?? [] }
    }

    var recipeAllergenInformation: [String] {
        get { allergenInformation ?? [] }
    }

    var recipeTipsAndVariations: [String] {
        get { tipsAndVariations ?? [] }
    }
}

extension V0_Recipe {
    init(record: CKRecord) {
        ckRecordID = record.recordID
        title = record[Self.kTitle] as? String ?? "No title"
        content = record[Self.kContent] as? String ?? ""
        instructions = record[Self.kInstructions] as? [String] ?? []
        allergenInformation = record[Self.kAllergenInformation] as? [String] ?? []
        tipsAndVariations = record[Self.kTipsAndVariations] as? [String] ?? []
        squareAsset = record[Self.kSquareAsset] as? CKAsset
        bannerAsset = record[Self.kBannerAsset] as? CKAsset

        category = record[Self.kCategory] as? CKRecord.Reference
        mealType = record[Self.kMealType] as? CKRecord.Reference
        stat = record[Self.kStat] as? CKRecord.Reference
        ingredient = record[Self.kIngredient] as? CKRecord.Reference
    }
}

extension V0_Recipe: Equatable {
    public static func ==(lhs: V0_Recipe, rhs: V0_Recipe) -> Bool {
        lhs.ckRecordID == rhs.ckRecordID
    }
}

extension V0_Recipe: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension V0_Recipe: Identifiable {
    var id: String { ckRecordID.recordName }
}

//extension RKRecipe {
//    static var example = RKRecipe(record: MockData.recipe)
//}
