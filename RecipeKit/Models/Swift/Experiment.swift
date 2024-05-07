//
//  Experiment.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/29/24.
//

import Foundation

struct Experiment {
    var test: ExperimentUnderTest
    var value: ExperimentationValue
}

enum ExperimentUnderTest: String, Hashable, CaseIterable {
    // Launch Darkly
    case exampleFeature = "lum-xxxx-example-feature"
    case enablePantryView = "enable-pantry-view"
    case enableAwardsView = "enable-awards-view"
    case enableSettingsView = "enable-settings-view"

    var testingType: TestingType {
        switch self {
        case .exampleFeature: return .bool
        case .enablePantryView: return .bool
        case .enableAwardsView: return .string
        case .enableSettingsView: return .bool
        }
    }

    enum TestingType {
        case bool
        case string
        case double
    }
}

enum ExperimentationValue {
    case boolean(Bool)
    case string(String)
    case double(Double)

    init(_ boolean: Bool) { self = .boolean(boolean) }
    init(_ string: String) { self = .string(string) }
    init(_ double: Double) { self = .double(double) }
}
