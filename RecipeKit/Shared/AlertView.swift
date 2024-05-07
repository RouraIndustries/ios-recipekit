//
//  AlertView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 5/3/24.
//

import SwiftUI
import Tuxedo

struct AlertView: View {
    @Binding var alertItem: AlertItem?

    var body: some View {
        VStack(spacing: 16.0) {
            VStack(spacing: 8.0) {
                alertItem?.title
                    .tuxedoFont(.h5Bold)
                    .foregroundStyle(.foregroundPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                alertItem?.message
                    .tuxedoFont(.h5Light)
                    .foregroundStyle(.foregroundPrimary)
                    .lineLimit(3)
                    .minimumScaleFactor(0.6)
                    .multilineTextAlignment(.center)
            }

            Spacer()

            Button { withAnimation { alertItem = nil }} label: {
                alertItem?.dismissButton
                    .tuxedoFont(.bodyExtraBold)
                    .foregroundStyle(.whitePrimary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(.midnightPrimary)
                    .clipShape(.rect(cornerRadius: 8.0))
            }
        }
        .padding(.horizontal, 32.0)
        .padding(.vertical, 32.0)
        .frame(width: 343, height: 208)
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
    AlertView(alertItem: .constant(AlertContext.noUserRecord))
}

extension View {
    func alert(_ item: Binding<AlertItem?>) -> some View {
        self.overlay {
            if item.wrappedValue != nil {
                withAnimation {
                    AlertView(alertItem: item)
                }
            }
        }
    }
}
