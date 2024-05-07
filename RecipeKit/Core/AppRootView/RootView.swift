//
//  RootView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/27/24.
//

import SwiftUI

struct RootView: View {
    static private let kHasSeenOnboardView = "hasSeenOnboardView"
    @Environment(\.experimentationFacade) private var experimentationFacade
    @Environment(\.cloudKitManager) private var cloudKitManager

    @State private var isShowingOnboardView = false
    @AppStorage(kHasSeenOnboardView) var hasSeenOnboardView = false {
        didSet { isShowingOnboardView = hasSeenOnboardView }
    }

    var body: some View {
        AppTabView()
            .onAppear { runStartupChecks() }
            .sheet(isPresented: $isShowingOnboardView) {
                OnboardView()
            }
    }

    init() {
        UIApplication.shared.isIdleTimerDisabled = true
    }

    func runStartupChecks() {
        if !hasSeenOnboardView {
            isShowingOnboardView = true
            hasSeenOnboardView = true
        } else {
            Task { @MainActor in
                setUpExperimentationFacade()
            }
        }
    }

    func setUpExperimentationFacade() {
        experimentationFacade.initialize {
            experimentationFacade.refreshExperiments()
        }
    }
}

#Preview {
    RootView()
        .environment(\.cloudKitManager, CloudKitManager())
}
