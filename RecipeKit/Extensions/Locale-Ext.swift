//
//  Locale-Ext.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/29/24.
//

import Foundation

extension Locale {
    static var localeString: String {
        Locale.current.language.languageCode?.identifier ?? ""
    }
}
