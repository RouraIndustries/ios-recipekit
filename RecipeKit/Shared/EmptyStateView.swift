//
//  EmptyStateView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 5/3/24.
//

import SwiftUI

struct EmptyStateView: View {
    let title: String
    let systemImage: String
    let description: String

    var body: some View {
        ContentUnavailableView(title, systemImage: systemImage, description: Text(description))
    }
}

#Preview {
    EmptyStateView(title: "", systemImage: "", description: "")
}
