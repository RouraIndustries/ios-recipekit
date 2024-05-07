//
//  ExperimentationUtilities.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/29/24.
//

typealias VariantResult = ExperimentationFacade.VariationResult
typealias FlagActivationResult = Bool
typealias EmptyCallback = (() -> Void)?

protocol ExperimentationAgent: HandlesUserTypes {
    func initialize(_ completion: EmptyCallback)
    func terminate()
    func refreshExperiments()
}

protocol HandlesUserTypes {
    func handleUserLogin()
    func handleUserLogOut()
}

protocol ExperimentsWithFeatureFlags {
    func featureFlagIsActive(_ experiment: ExperimentUnderTest) -> FlagActivationResult
}

protocol ExperimentsWithVariations {
    func variation(forExperiment experiment: ExperimentUnderTest) -> VariantResult
}

protocol ExperimentsWithNumbers {
    func getVariationNumber(for experiment: ExperimentUnderTest) -> Double?
}
