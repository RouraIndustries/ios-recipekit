//
//  CuisineTypeRecipeListView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/28/24.
//

import SwiftUI
import CloudKit
import Tuxedo

struct CuisineTypeRecipeListView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.recipeManager) private var recipeManager

    let cuisineType: V0_CuisineType
    let recipes: [V0_Recipe]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16.0) {
                ForEach(recipes) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeCard(style: .large, recipe: recipe)
                    }
                    .buttonStyle(.plain)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .contentMargins(.horizontal, 16.0, for: .scrollContent)
        .padding(.vertical, 12.0)
        .background(.backgroundPrimary)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: .zero) {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(.midnightPrimary)
                            .fontWeight(.bold)
                    }
                    .frame(width: 34, height: 50, alignment: .leading)

                    Text(cuisineType.cuisineType.rawValue)
                        .tuxedoFont(.h5Bold)
                        .foregroundStyle(.foregroundPrimary)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CuisineTypeRecipeListView(cuisineType: V0_CuisineType(record: CKRecord(recordType: RecordType.cuisineType)), recipes: [])
    }
}
