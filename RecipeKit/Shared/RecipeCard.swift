//
//  RecipeCard.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/18/24.
//

import SwiftUI
import CloudKit
import Tuxedo

enum CardStyle {
    case small
    case standard
    case large
}

struct RecipeCard: View {
    @Environment(\.recipeManager) private var recipeManager

    var style: CardStyle = .standard
    let recipe: V0_Recipe

    var mealType: String {
        recipeManager.mealTypes
            .first { $0.ckRecordID == recipe.mealType?.recordID }?
            .recipeMealType.rawValue ?? ""
    }

    var calories: String {
        let caloriesForRecipe = recipeManager.macros.filter { $0.recipe?.recordID == recipe.ckRecordID }.first
        return "\(caloriesForRecipe?.macroName ?? "") \(caloriesForRecipe?.macroUnitLabel ?? "")"
    }

    var body: some View {
        switch style {
        case .small: small
        case .standard: standard
        case .large: large
        }
    }

    var small: some View {
        HStack(spacing: 16.0) {
            recipe.squareImage
                .resizable()
                .scaledToFill()
                .frame(width: 96.0, height: 96.0)
                .clipShape(.rect(cornerRadius: 16.0))

            VStack(alignment: .leading, spacing: 4.0) {
                Text(recipe.recipeTitle)
                    .tuxedoFont(.h5Bold)
                    .foregroundStyle(.foregroundPrimary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
                    .multilineTextAlignment(.leading)

                Text(mealType)
                    .tuxedoFont(.bodyExtraBold)
                    .foregroundStyle(.foregroundSecondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)

                Group {
                    Text(calories)
                        .tuxedoFont(.captionExtraBold)
                        .foregroundStyle(.foregroundSecondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(width: 14.0, height: 14.0)
                .foregroundStyle(.foregroundDisabled)
                .fontWeight(.bold)
        }
        .padding(.horizontal, 16.0)
        .padding(.vertical, 12.0)
        .background(.backgroundRecessed)
        .clipShape(.rect(cornerRadius: 16.0))
        .shadow(color: .shadow, radius: 8, y: 4)
    }

    var standard: some View {
        ZStack(alignment: .bottomLeading) {
            recipe.squareImage
                .resizable()
                .scaledToFill()
                .frame(
                    minWidth: .zero,
                    maxWidth: .infinity,
                    minHeight: .zero,
                    maxHeight: .infinity
                )

            VStack(alignment: .leading, spacing: 4.0) {
                Text(recipe.recipeTitle)
                    .tuxedoFont(.h5Bold)
                    .foregroundStyle(.foregroundPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)

                Text(mealType)
                    .tuxedoFont(.bodyExtraBold)
                    .foregroundStyle(.foregroundSecondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)

                Group {
                    Text(calories)
                        .tuxedoFont(.captionExtraBold)
                        .foregroundStyle(.foregroundSecondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12.0)
            .background(.ultraThinMaterial)
            .background(.backgroundPrimary.opacity(0.8))
        }
        .frame(width: 220, height: 204)
        .clipShape(.rect(cornerRadius: 16.0))
        .padding(.bottom, 16.0)
        .shadow(color: .shadow, radius: 8, y: 4)
    }

    var large: some View {
        ZStack(alignment: .bottomLeading) {
            recipe.squareImage
                .resizable()
                .scaledToFill()
                .frame(
                    minWidth: .zero,
                    maxWidth: .infinity,
                    minHeight: .zero,
                    maxHeight: .infinity
                )

            VStack(alignment: .leading, spacing: 8.0) {
                Text(recipe.recipeTitle)
                    .tuxedoFont(.h5Bold)
                    .foregroundStyle(.foregroundPrimary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
                    .multilineTextAlignment(.leading)

                Text(mealType)
                    .tuxedoFont(.h5Light)
                    .foregroundStyle(.foregroundSecondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)

                Group {
                    Text(calories)
                        .tuxedoFont(.bodyBold)
                        .foregroundStyle(.foregroundSecondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
            }
            .frame(height: 96)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
            .background(.ultraThinMaterial)
            .background(.backgroundPrimary.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 320)
        .clipShape(.rect(cornerRadius: 16.0))
        .padding(.bottom, 16.0)
        .shadow(color: .shadow, radius: 8, y: 4)
    }
}

#Preview {
    RecipeCard(style: .small, recipe: V0_Recipe(record: CKRecord(recordType: RecordType.recipe)))
}
