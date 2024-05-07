//
//  Config.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/29/24.
//

import UIKit

final class Config: NSObject {
    static var environment: Environment = {
#if DEV
        return .dev
#elseif QA
        return .qa
#elseif PRODUCTION
        return .production
#else
        return .appStore
#endif
    }()

    static var pushEnvironment: Environment = {
#if DEV || QA || PRODUCTION
        return .dev
#else
        return .appStore
#endif
    }()

    enum Environment {
        case dev
        case qa
        case production
        case appStore

        var url: String {
            switch self {
            case .dev:          return "https://api-dev.recipekit.com/api/"
            case .qa:           return "https://api-qa.recipekit.com/api/"
            case .production:   return "https://api.recipekit.com/api/"
            case .appStore:     return "https://api.recipekit.com/api/"
            }
        }

        var urlWithVersion: String {
            "\(url)\(version)"
        }

        var version: String {
            "v1"
        }

        var name: String {
            switch self {
            case .dev:          return "DEV"
            case .qa:           return "QA"
            case .production:   return "PRODUCTION"
            case .appStore:     return "APPSTORE"
            }
        }

        var bundleId: String {
            switch self {
            case .dev:          return "com.recipekit-dev"
            case .qa:           return "com.recipekit-qa"
            case .production:   return "com.recipekit"
            case .appStore:     return "com.recipekit"
            }
        }

        var ldMobileKey: String {
            switch self {
            case .dev:          return "mob-2a752580-c010-4cad-a6de-9a434cf7853d"
            case .qa:           return "mob-083eee17-9a18-4d3e-a507-3a3d8cab8d1a"
            case .production:   return "mob-8210a676-1364-400f-8497-c69b05f6a6e7"
            case .appStore:     return "mob-8210a676-1364-400f-8497-c69b05f6a6e7"
            }
        }

        var ldAnonymousUserKey: String {
            switch self {
            case .dev:          return "luminae.ios.anonymous-dev"
            case .qa:           return "luminae.ios.anonymous-qa"
            case .production:   return "luminae.ios.anonymous"
            case .appStore:     return "luminae.ios.anonymous"
            }
        }
    }

    static let accessibilitySupportEmail = "accessibility.recipekit@gmail.com"

    static let localeString = Locale.localeString
    static let deviceUniqueId = UIDevice.deviceUniqueId
    static let localizedDeviceModel = UIDevice.localizedDeviceModel
}
