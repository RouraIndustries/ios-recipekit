//
//  RecipeDetailsView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/27/24.
//

import SwiftUI
import CloudKit

struct RecipeDetailsView: View {
    @Environment(\.recipeManager) private var recipeManager
    @Environment(\.cloudKitManager) private var cloudKitManager
    @State private var viewModel: ViewModel
    let recipe: V0_Recipe

    init(recipe: V0_Recipe) {
        self.recipe = recipe
        _viewModel = State(wrappedValue: ViewModel(recipe: recipe))
    }
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Text(recipe.recipeTitle)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
                    .multilineTextAlignment(.center)

                VStack(spacing: 16.0) {
                    VStack(spacing: 8.0) {
                        if viewModel.mealType.isEmpty == false {
                            Text(viewModel.mealType)
                        }

                        Text(recipe.recipeContent)
                            .lineLimit(3)
                            .minimumScaleFactor(0.75)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        }
        .task {
            viewModel.recipeManager = recipeManager
            viewModel.cloudKitManager = cloudKitManager
            await viewModel.fetchDataTaskGroup()
        }
        .overlay { if viewModel.isLoading { LoadingView() }}
    }
}

#Preview {
    RecipeDetailsView(recipe: V0_Recipe(record: CKRecord(recordType: RecordType.recipe)))
}
