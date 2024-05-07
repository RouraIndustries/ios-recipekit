//
//  ExperimentationManager.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/29/24.
//

import Foundation
import Combine
import RouraFoundation

final class ExperimentationFacade {
    private var launchDarklyAgentDidRefreshExperimentsOnce: Bool {
        experimentationAgents
            .compactMap { $0 as? LaunchDarklyAgent }
            .first?.didRefreshExperimentsOnce ?? false
    }
    private var cancellables = Set<AnyCancellable>()

    /// Experimentation Agents ordered by priority. If two agents both have the same test, the
    ///  first one in the list will be used.
    private let experimentationAgents: [ExperimentationAgent]

    init(experimentationAgents: [ExperimentationAgent]) {
        self.experimentationAgents = experimentationAgents
    }
}

// MARK: - Utilities

extension ExperimentationFacade {
    enum VariationResult {
        case control
        case variant
        case nthVariant(String)
    }
}

extension ExperimentationFacade.VariationResult: Equatable {
    static func == (lhs: ExperimentationFacade.VariationResult, rhs: ExperimentationFacade.VariationResult) -> Bool {
        switch (lhs, rhs) {
        case (.control, .control):
            return true
        case (.variant, .variant):
            return true
        case let (.nthVariant(value1), .nthVariant(value2)):
            return value1 == value2
        default:
            return false
        }
    }
}

// MARK: - Launch/Termination

extension ExperimentationFacade {
    func initialize(_ completion: EmptyCallback) {
        experimentationAgents.forEach { $0.initialize(completion) }
    }

    func terminate() {
        experimentationAgents.forEach { $0.terminate() }
    }

    func refreshExperiments() {
        experimentationAgents.forEach { $0.refreshExperiments() }
    }
}

// MARK: - Logging In/Out

extension ExperimentationFacade: HandlesUserTypes {
    func handleUserLogin() {
        experimentationAgents.forEach { $0.handleUserLogin() }
    }

    func handleUserLogOut() {
        experimentationAgents.forEach { $0.handleUserLogOut() }
    }
}

// MARK: - ExperimentsWithFeatureFlags

extension ExperimentationFacade: ExperimentsWithFeatureFlags {
    func featureFlagIsActive(_ experiment: ExperimentUnderTest) -> FlagActivationResult {
        let agent = experimentationAgents.compactMap { $0 as? ExperimentsWithFeatureFlags }.first
        let isFlagActive = agent?.featureFlagIsActive(experiment) ?? false

        return isFlagActive
    }

    func performAfterRefreshedLaunchDarklyExperimentsOnce(timeout: TimeInterval,
                                                          _ completion: ((_ finished: Bool) -> Void)?) {
        guard launchDarklyAgentDidRefreshExperimentsOnce == false else {
            Log.info("LaunchDarkly - Experiments are ready.")
            DispatchQueue.main.async { completion?(true) }
            return
        }

        let startTime = Date()
        Log.info("LaunchDarkly - Waiting for experiments")

        // Because of the prefix(1), the publisher will only fire once and then complete.
        // No need to observe the receiveValue block.
        NotificationCenter.default.publisher(for: .launchDarklyAgentDidRefreshExperiments)
            .prefix(1)
            .timeout(.seconds(timeout), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                let refreshed = self?.launchDarklyAgentDidRefreshExperimentsOnce == true
                let elapsedSeconds = Date().timeIntervalSince(startTime)
                if refreshed {
                    Log.info("LaunchDarkly - Refreshed experiments in \(elapsedSeconds) seconds.")
                } else {
                    Log.info("LaunchDarkly - Failed to recieve experiments on time. \(elapsedSeconds) seconds passed.")
                }
                completion?(refreshed)
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
}

// MARK: - ExperimentsWithFeatureFlags

extension ExperimentationFacade: ExperimentsWithVariations {
    func variation(forExperiment experiment: ExperimentUnderTest) -> VariantResult {
        let agent = experimentationAgents.compactMap { $0 as? ExperimentsWithVariations }.first
        return agent?.variation(forExperiment: experiment) ?? .control
    }
}

// MARK: - ExperimentsWithNumbers

extension ExperimentationFacade: ExperimentsWithNumbers {
    func getVariationNumber(for experiment: ExperimentUnderTest) -> Double? {
        let agent = experimentationAgents.compactMap{ $0 as? ExperimentsWithNumbers }.first
        return agent?.getVariationNumber(for: experiment)
    }
}

extension ExperimentationFacade {
    var enablePantryView: Bool {
        featureFlagIsActive(.enablePantryView)
    }

    var enableAwardsView: VariantResult {
        variation(forExperiment: .enableAwardsView)
    }

    var enableSettingsView: Bool {
        featureFlagIsActive(.enableSettingsView)
    }
}
