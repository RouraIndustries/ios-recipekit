//
//  View-Ext.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 3/29/24.
//

import SwiftUI

extension View {
    func applySafeAreaGradient() -> some View {
        background(SafeAreaButtonGradient())
    }
}
