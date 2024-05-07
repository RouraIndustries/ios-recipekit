//
//  ExperimentationManagerEnvironmentKey.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/29/24.
//

import SwiftUI

private struct ExperimentationFacadeEnvironmentKey: EnvironmentKey {
    static var defaultValue = ExperimentationFacade(experimentationAgents: [
        LaunchDarklyAgent(cloudKitManager: CloudKitManager())
    ])
}

extension EnvironmentValues {
    var experimentationFacade: ExperimentationFacade {
        get { self[ExperimentationFacadeEnvironmentKey.self] }
        set { self[ExperimentationFacadeEnvironmentKey.self] = newValue }
    }
}
