//
//  LoadingView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/26/24.
//

import SwiftUI
import Tuxedo

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 12.0) {
            ProgressView()
                .foregroundStyle(.midnightPrimary)

            Text("Loading...")
                .tuxedoFont(.bodyExtraBold)
                .foregroundStyle(.foregroundPrimary)
        }
        .padding(.horizontal, 32.0)
        .padding(.vertical, 32.0)
        .background(.backgroundPrimary)
        .clipShape(.rect(cornerRadius: 12.0))
        .overlay {
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(.foregroundDisabled, lineWidth: 1.0)
        }
        .shadow(color: .shadow, radius: 8, y: 4)
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

#Preview {
    LoadingView()
}
