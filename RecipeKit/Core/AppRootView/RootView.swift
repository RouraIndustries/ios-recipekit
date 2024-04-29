//
//  RootView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/27/24.
//

import SwiftUI

struct RootView: View {
    static private let kHasSeenOnboardView = "hasSeenOnboardView"
    @Environment(\.cloudKitManager) private var cloudKitManager

    @State private var isShowingOnboardView = false
    @AppStorage(kHasSeenOnboardView) var hasSeenOnboardView = false {
        didSet { isShowingOnboardView = hasSeenOnboardView }
    }

    var body: some View {
        AppTabView()
            .onAppear { runStartupChecks() }
            .sheet(isPresented: $isShowingOnboardView) {
                //                OnboardView()
            }
    }

    func runStartupChecks() {
        if !hasSeenOnboardView {
            isShowingOnboardView = true
            hasSeenOnboardView = true
        }
    }
}

#Preview {
    RootView()
}
