//
//  UIDevice-Ext.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/29/24.
//

import UIKit

extension UIDevice {
    static var deviceUniqueId: String {
        UIDevice.current.identifierForVendor?.uuidString ?? ""
    }

    static var localizedDeviceModel: String {
        UIDevice.current.localizedModel
    }
}
