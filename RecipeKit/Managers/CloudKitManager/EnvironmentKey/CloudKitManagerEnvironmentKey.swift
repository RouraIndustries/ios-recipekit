//
//  CloudKitManagerEnvironmentKey.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/28/24.
//

import SwiftUI

private struct CloudKitManagerEnvironmentKey: EnvironmentKey {
    static var defaultValue = CloudKitManager()
}

extension EnvironmentValues {
    var cloudKitManager: CloudKitManager {
        get { self[CloudKitManagerEnvironmentKey.self] }
        set { self[CloudKitManagerEnvironmentKey.self] = newValue }
    }
}
