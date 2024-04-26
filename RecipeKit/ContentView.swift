//
//  ContentView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/19/24.
//

import SwiftUI

struct ContentView: View {
    private let cloudKitManager = CloudKitManager()

    var body: some View {
        AppTabView()
            .environmentObject(cloudKitManager)
    }
}

#Preview {
    ContentView()
}
