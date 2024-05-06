//
//  AppTabView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/19/24.
//

import SwiftUI
import Tuxedo

struct AppTabView: View {
    @SceneStorage("tabSelection") private var tabSelection: String?

    var body: some View {
        TabView(selection: $tabSelection) {
            RecipeExploreView()
                .tag(RecipeExploreView.tag)
                .tabItem {
                    Label { Text("Recipes") } icon: {
                        Image(systemName: "house")
                            .environment(\.symbolVariants, (tabSelection == RecipeExploreView.tag || tabSelection == nil) ? .fill : .none)
                    }
                }

            SavedRecipesView()
                .tag(SavedRecipesView.tag)
                .tabItem {
                    Label { Text("Saved Recipes") } icon: {
                        Image(systemName: "star")
                            .environment(\.symbolVariants, tabSelection == SavedRecipesView.tag ? .fill : .none)
                    }
                }

            ProfileView()
                .tag(ProfileView.tag)
                .tabItem {
                    Label { Text("Profile") } icon: {
                        Image(systemName: "person")
                            .environment(\.symbolVariants, tabSelection == ProfileView.tag ? .fill : .none)
                    }
                }
        }
        .tint(.midnightPrimary)
    }
}

#Preview {
    AppTabView()
}
