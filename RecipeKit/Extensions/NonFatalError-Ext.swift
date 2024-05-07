//
//  NonFatalError-Ext.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/29/24.
//

import RouraFoundation
import Foundation

extension NonFatalError {
    static func unavailableFont(name: String) -> NonFatalError {
        let domain: String = "Font Style Unavailable - \(name)"
        let code: Int = 100
        let userInfo: [String: Any] = [
            NSLocalizedDescriptionKey: "The app could not load the requested font: \(name)."
        ]

        return NonFatalError(domain: domain, code: code, userInfo: userInfo)
    }

    static var clientStartFailure: NonFatalError {
        let domain: String = "LaunchDarkly"
        let code: Int = 501
        let userInfo: [String: Any] = [
            NSLocalizedDescriptionKey: "Launch Darkly client not started! Make sure you run LaunchDarklyAgent.start() before attempting to use safeLDClient."
        ]

        return NonFatalError(domain: domain, code: code, userInfo: userInfo)
    }

    static var launchDarklyAllFlagsFailure: NonFatalError {
        let domain: String = "LaunchDarkly"
        let code: Int = 501
        let userInfo: [String: Any] = [
            NSLocalizedDescriptionKey: "Failed to retrieve all flags from Launch Darkly. Make sure the LDClient has been implemented correctly."
        ]

        return NonFatalError(domain: domain, code: code, userInfo: userInfo)
    }
}
