//
//  LDContext-Ext.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/29/24.
//

import LaunchDarkly
import UIKit

extension LDContext {
    static func set(for user: V0_Profile? = nil) -> LDContext? {
        var contextBuilder = LDContextBuilder()
        contextBuilder.key(user?.identifier ?? Config.environment.ldAnonymousUserKey)

        let customAttributes = LDContextAttributesFactory.build(for: user)
        customAttributes.forEach { contextBuilder.trySetValue($0.key, $0.value) }

        contextBuilder.anonymous(user?.identifier.isEmpty == true ? true : false)

        return try? contextBuilder.build().get()
    }
}

struct LDContextAttributesFactory {
    static func build(for user: V0_Profile? = nil) -> [String: LDValue] {
        let platform    = LDValue(stringLiteral: "ios_recipekit")
        let appVersion  = LDValue(stringLiteral: UIApplication.appVersion)

        if let user = user {
            return [
                "platform": platform,
                "appVersion": appVersion,
                "userID": LDValue(stringLiteral: user.identifier),
                "deviceType": LDValue(stringLiteral: "\(Config.localizedDeviceModel) - iOS"),
                "deviceID": LDValue(stringLiteral: Config.deviceUniqueId)
            ]
        } else {
            return [
                "platform": platform,
                "appVersion": appVersion,
                "deviceType": LDValue(stringLiteral: "\(Config.localizedDeviceModel) - iOS"),
                "deviceID": LDValue(stringLiteral: Config.deviceUniqueId)
            ]
        }
    }
}
