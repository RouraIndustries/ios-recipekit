//
//  RecipeCard.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/18/24.
//

import SwiftUI
import CloudKit

enum CardStyle {
    case small
    case standard
    case large
}

struct RecipeCard: View {
    var style: CardStyle = .standard
    let recipe: V0_Recipe

    var body: some View {
        switch style {
        case .small: small
        case .standard: standard
        case .large: large
        }
    }

    var small: some View {
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
                Text("Recipe")
                    .fontWeight(.bold)

                Text("Recipe")
                    .font(.subheadline)
            }
            .frame(height: 78)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .background(.background)
        }
        .frame(width: 220, height: 204)
        .clipShape(.rect(cornerRadius: 16.0))
        .padding(.bottom, 16.0)
        .shadow(color: Color(red: 23 / 255, green: 27 / 255, blue: 31 / 255, opacity: 0.16), radius: 8, y: 4)
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

            VStack(alignment: .leading, spacing: 8.0) {
                Text("Recipe")
                    .fontWeight(.bold)

                Text("Recipe")
                    .font(.subheadline)
            }
            .frame(height: 78)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .background(.background)
        }
        .frame(width: 220, height: 204)
        .clipShape(.rect(cornerRadius: 16.0))
        .padding(.bottom, 16.0)
        .shadow(color: Color(red: 23 / 255, green: 27 / 255, blue: 31 / 255, opacity: 0.16), radius: 8, y: 4)
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
                Text("Recipe")
                    .fontWeight(.bold)

                Text("Recipe")
                    .font(.subheadline)
            }
            .frame(height: 78)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .background(.background)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 320)
        .clipShape(.rect(cornerRadius: 16.0))
        .padding(.bottom, 16.0)
        .shadow(color: Color(red: 23 / 255, green: 27 / 255, blue: 31 / 255, opacity: 0.16), radius: 8, y: 4)
    }
}

#Preview {
    RecipeCard(recipe: V0_Recipe(record: CKRecord(recordType: RecordType.recipe)))
}
