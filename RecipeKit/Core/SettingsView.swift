//
//  SettingsView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 5/5/24.
//

import SwiftUI
import Tuxedo

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isUsingMetricUnits") private var isUsingMetricUnits = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Toggle("Use metrics", isOn: $isUsingMetricUnits)
            }
            .contentMargins(.horizontal, 16.0, for: .scrollContent)
            .padding(.vertical, 12.0)
            .background(.backgroundPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: .zero) {
                        Button { dismiss() } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .symbolRenderingMode(.hierarchical)
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.midnightPrimary)
                                .fontWeight(.bold)
                        }
                        .frame(width: 34, height: 50, alignment: .leading)

                        Text("Settings")
                            .tuxedoFont(.h5Bold)
                            .foregroundStyle(.foregroundPrimary)
                            .minimumScaleFactor(0.5)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
