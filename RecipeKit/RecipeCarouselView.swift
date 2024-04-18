//
//  RecipeCarouselView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/17/24.
//

import SwiftUI

struct RecipeCarouselView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16.0) {
                ForEach(0 ..< 10, id: \.self) { item in
                    RecipeCard(item: item)
                }
            }
        }
        .contentMargins(.horizontal, 16.0, for: .scrollContent)
    }
}

#Preview {
    RecipeCarouselView()
}
