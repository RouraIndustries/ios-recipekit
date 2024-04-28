//
//  RecipeCard.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/18/24.
//

import SwiftUI
import CloudKit

struct RecipeCard: View {
    let recipe: V0_Recipe

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.gray

            VStack(alignment: .leading, spacing: 8.0) {
                Text("Recipe")
                    .font(.headline)
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
        .shadow(color: Color(red: 23/255, green: 27/255, blue: 31/255, opacity: 0.16), radius: 8, y: 4)
    }
}

#Preview {
    RecipeCard(recipe: V0_Recipe(record: CKRecord(recordType: RecordType.recipe)))
}
