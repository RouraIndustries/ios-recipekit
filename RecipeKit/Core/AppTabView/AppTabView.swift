//
//  AppTabView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/19/24.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            RecipeExploreView()
                .tabItem { Label("Home", systemImage: "house") }

            SavedRecipesView()
                .tabItem { Label("Saved Recipes", systemImage: "star") }

            ProfileView()
                .tabItem { Label("Profile", systemImage: "person") }
        }
    }
}

#Preview {
    AppTabView()
}
