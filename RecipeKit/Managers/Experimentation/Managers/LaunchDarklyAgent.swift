//
//  LaunchDarklyAgent.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/29/24.
//

import Foundation
import LaunchDarkly
import RouraFoundation

final class LaunchDarklyAgent: ExperimentationAgent {
    private(set) var didRefreshExperimentsOnce: Bool = false

    private struct Constants {
        static let variant: String = "Treatment 1"
    }

    private var allFlags: [String: LDValue] = [:]
    private var experiments: [Experiment] = [] {
        didSet {
            didRefreshExperimentsOnce = true
            NotificationCenter.default.post(name: .launchDarklyAgentDidRefreshExperiments, object: nil)
        }
    }

    private let cloudKitManager: CloudKitManager

    init(cloudKitManager: CloudKitManager) {
        self.cloudKitManager = cloudKitManager
    }

    private var ldContext: LDContext? {
        if let userRecord = cloudKitManager.userRecord {
            LDContext.set(for: V0_Profile(record: userRecord))
        } else {
            LDContext.set()
        }
    }

    private var safeLDClient: LDClient {
        get throws {
            if let client = LDClient.get() {
                return client
            } else {
                initialize(nil)
                guard let client = LDClient.get() else {
                    Log.nonfatal(.clientStartFailure)
                    throw NonFatalError.clientStartFailure
                }
                return client
            }
        }
    }

    lazy private var config: LDConfig = {
        var config = LDConfig(mobileKey: Config.environment.ldMobileKey, autoEnvAttributes: .disabled)
        config.evaluationReasons = true
        return config
    }()
}

// MARK: - Initialization

extension LaunchDarklyAgent {
    func initialize(_ completion: EmptyCallback) {
        LDClient.start(config: config, context: ldContext, startWaitSeconds: 5) { timedOut in
            completion?()
        }
    }

    /// Using `close()` is a performance gain for LaunchDarkly when terminating the app. We will let it silently
    /// fail because the client would have to be empty on startup and then be terminated. LDClient should never
    /// be nil unless if the client is not set up before `LDClient.start()` is ran.
    func terminate() {
        try? safeLDClient.close()
    }
}

// MARK: - HandlesUserTypes

extension LaunchDarklyAgent {
    /// identify loads any saved flag values for the new user and immediately triggers an update of the latest flags from LaunchDarkly.
    ///
    /// If multiple users use your app on a single device, you may want to change users and have separate flag settings for each one.
    /// To do this, the SDK stores the last five user contexts on a single device, with support for switching between different user contexts.
    /// You can use the identify method to switch user contexts. When a new user is identified, the SDK temporarily goes offline while reconnecting on behalf of the new user.
    /// Upon successfully reconnecting, the SDK comes back online and calls the optional completion if one was provided.
    /// If the client app does not identify an LDUser, LDClient creates an anonymous default user, which can affect which feature flags LaunchDarkly delivers to the LDClient.
    ///
    /// - Parameter completion: Optional completion handler
    private func identifyAndReconnect(_ completion: EmptyCallback = nil) {
        guard let ldContext = ldContext else {
            completion?()
            return
        }

        if let client = LDClient.get() {
            client.identify(context: ldContext) { _ in
                DispatchQueue.main.async {
                    completion?()
                }
            }
        } else {
            initialize {
                if let client = LDClient.get() {
                    client.identify(context: ldContext) { _ in
                        DispatchQueue.main.async {
                            completion?()
                        }
                    }
                } else {
                    completion?()
                }
            }
        }
    }

    private func identifyAndRefresh(_ completion: EmptyCallback = nil) {
        identifyAndReconnect() {
            self.refreshExperiments()
            completion?()
        }
    }

    func handleUserLogin() { identifyAndRefresh() }
    func handleUserLogOut() { identifyAndRefresh() }
}

// MARK: - State

extension LaunchDarklyAgent {
    func refreshExperiments() {
        refreshFlags()
        var parsedExperiments: [Experiment] = []

        for key in allFlags.keys {
            if let eut = ExperimentUnderTest(rawValue: key) {
                /// We intentionally call the detail version of stringVariation and boolVariation.
                /// The detail version logs reason which BA needs.
                switch eut.testingType {
                case .string:
                    if let detail = try? safeLDClient.stringVariationDetail(forKey: key,
                                                                            defaultValue: "") {
                        parsedExperiments.append(Experiment(test: eut,
                                                            value: .string(detail.value)))
                    }

                case .bool:
                    if let detail = try? safeLDClient.boolVariationDetail(forKey: key,
                                                                          defaultValue: false) {
                        parsedExperiments.append(Experiment(test: eut,
                                                            value: .boolean(detail.value)))
                    }
                case .double:
                    if let detail = try? safeLDClient.doubleVariationDetail(forKey: key, defaultValue: -1.0) {
                        parsedExperiments.append(Experiment(test: eut, value: .double(detail.value)))
                    }
                }
            }
        }

        experiments = parsedExperiments
    }

    private func refreshFlags() {
        guard let fetchedFlags = try? safeLDClient.allFlags else {
            Log.nonfatal(.launchDarklyAllFlagsFailure)
            return
        }

        allFlags = fetchedFlags
    }

    private func find(experiment: ExperimentUnderTest) -> Experiment? {
        return experiments.first(where: {
            $0.test == experiment
        })
    }
}

// MARK: - ExperimentsWithFeatureFlags

extension LaunchDarklyAgent: ExperimentsWithFeatureFlags {
    /// Checks an experiment under test to see if its value is true or false, indicating its active or inactive state.
    ///  if a string value is present, it will attempt to initialize a Bool with it. In the case a variation string is found,
    ///  false will be returned since this tests for Feature Flags.
    /// - Parameter experiment: The Experiment to be evaluated.
    /// - Returns: True  or False
    func featureFlagIsActive(_ experiment: ExperimentUnderTest) -> FlagActivationResult {
        guard
            experiment.testingType == .bool,
            let value = find(experiment: experiment)?.value,
            case let .boolean(bool) = value
        else { return false }

        return bool
    }
}

// MARK: - ExperimentsWithVariations

extension LaunchDarklyAgent: ExperimentsWithVariations {
    /// Checks an experiment under test to see if its value is a variant. If a boolean is found then control will be returned.
    ///  If the variation string is not a boolean value and is anything other than "variant" then the nthVariation
    ///  result will be returned along with the variation string as an associated value.
    /// - Parameter experiment: The Experiment to be evaluated.
    /// - Returns: Control, Variant, NthVariant
    func variation(forExperiment experiment: ExperimentUnderTest) -> VariantResult {
        guard
            experiment.testingType == .string,
            let value = find(experiment: experiment)?.value,
            case let .string(string) = value
        else { return .control }

        return string.lowercased().replacingOccurrences(of: " ", with: "").elementsEqual(Constants.variant.lowercased().replacingOccurrences(of: " ", with: "")) ? .variant : .nthVariant(string)
    }
}

// MARK: - ExperimentsWithNumbers

extension LaunchDarklyAgent: ExperimentsWithNumbers {
    /// Checks an experiment under test to see if its value is a double. If the variation is not a double or the value is missing, nil will be returned.
    /// - Parameter experiment: The Experiment to be evaluated.
    /// - Returns: Optional double
    func getVariationNumber(for experiment: ExperimentUnderTest) -> Double? {
        guard
            experiment.testingType == .double,
            let launchDarklyValue = find(experiment: experiment)?.value,
            case let .double(experimentNumber) = launchDarklyValue else {
            Log.error("The experiment \(experiment) is not a double or is missing")
            return nil
        }

        return experimentNumber
    }
}
