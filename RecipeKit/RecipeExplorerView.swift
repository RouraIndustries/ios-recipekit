//
//  RecipeExplorerView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/17/24.
//

import SwiftUI

struct RecipeExplorerView: View {
    private let sampleCategories: [String] = ["American", "Italian", "Mediterranean"]

    @State private var showCreateRecipeView = false

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12.0) {
                    ForEach(sampleCategories, id: \.self) { category in
                        Section {
                            RecipeCarouselView()
                        } header: {
                            NavigationLink(value: category) {
                                Text(category)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16.0)
                        }
                    }
                }
            }
            .navigationDestination(for: String.self) { category in
                Text(category)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button { showCreateRecipeView.toggle() } label: {
                        Label("Add", systemImage: "plus")
                    }
                    .sheet(isPresented: $showCreateRecipeView) {
                        CreateRecipeView()
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeExplorerView()
}
