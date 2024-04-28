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

            SearchView()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }

            ProfileView()
                .tabItem { Label("Profile", systemImage: "person") }
        }
    }
}

#Preview {
    AppTabView()
}
