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
            Text("Home")
                .tabItem { Label("Home", systemImage: "house") }

            Text("Search")
                .tabItem { Label("Search", systemImage: "magnifyingglass") }

            Text("Profile")
                .tabItem { Label("Profile", systemImage: "person") }
        }
    }
}

#Preview {
    AppTabView()
}
