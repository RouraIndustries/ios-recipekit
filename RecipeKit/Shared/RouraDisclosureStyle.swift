//
//  RouraDisclosureStyle.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/29/24.
//

import SwiftUI
import Tuxedo

struct RouraDisclosureStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 12.0) {
            Button {
                withAnimation {
                    configuration.isExpanded.toggle()
                }
            } label: {
                HStack(alignment: .firstTextBaseline) {
                    configuration.label
                        .tuxedoFont(.bodyExtraBold)
                        .foregroundStyle(.foregroundPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)

                    Spacer()

                    HStack(alignment: .firstTextBaseline, spacing: 4.0) {
                        Text(configuration.isExpanded ? "Hide all".uppercased() : "Show all".uppercased())
                            .tuxedoFont(.captionExtraBold, useScaledFonts: false, option: .small)
                            .foregroundStyle(.midnightPrimary)
                            .animation(nil, value: configuration.isExpanded)

                        Image(systemName: configuration.isExpanded ? "chevron.down" : "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 6, height: 6)
                    }
                }
            }
            .buttonStyle(.plain)

            if configuration.isExpanded {
                configuration.content
            }
        }
        .padding(.horizontal, 12.0)
        .padding(.vertical, 8.0)
        .background(.backgroundRecessed)
        .clipShape(.rect(cornerRadius: configuration.isExpanded ? 12.0 : 8.0))
    }
}
