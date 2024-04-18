//
//  RecipeExplorerView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/17/24.
//

import SwiftUI

struct RecipeExplorerView: View {
    private let sampleCategories: [String] = ["American", "Italian", "Mediterranean"]

    var body: some View {
        NavigationStack {
            List {
                ForEach(sampleCategories, id: \.self) { category in
                    Section {

                    } header: {
                        NavigationLink(value: category) {
                            Text(category)
                        }
                    }
                }
            }
            .navigationDestination(for: String.self) { category in
                Text(category)
            }
        }
    }
}

#Preview {
    RecipeExplorerView()
}
