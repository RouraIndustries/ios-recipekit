//
//  AppTabView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/17/24.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            RecipeExplorerView()
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
