//
//  OnboardView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/27/24.
//

import SwiftUI

struct Onboard: Identifiable {
    let id = UUID()

    let title: LocalizedStringResource
    let description: LocalizedStringResource
    let icon: Image

    static var details: [Onboard] {
        [
            Onboard(
                title: "Unique Quick Recipes",
                description: "Discover a collection of unique recipes with handy tips, variations, and substitutions.",
                icon: Image(systemName: "star.circle")
            ),
            Onboard(
                title: "Quick and Easy",
                description: "Effortlessly prepare delicious meals in no time with our quick and easy recipes.",
                icon: Image(systemName: "stopwatch")
            ),
            Onboard(
                title: "Inspiration at Your Fingertips",
                description: "Explore a variety of curated recipes ready to inspire your next culinary adventure.",
                icon: Image(systemName: "heart.circle")
            )
        ]
    }
}

struct OnboardView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 64.0) {
                    Image(.recipekitLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)

                    Grid(alignment: .leading, horizontalSpacing: 16.0, verticalSpacing: 24.0) {
                        ForEach(Onboard.details, content: OnboardInfoRowView.init)
                    }
                }
                .padding(.horizontal, 36.0)
                .padding(.vertical, 16.0)
            }
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .safeAreaInset(edge: .bottom) {
                Button { dismiss() } label: {
                    Text("Continue")
                        .frame(width: 320, height: 50)
                        .clipShape(.rect(cornerRadius: 12.0))
                }
                .padding(.horizontal, 16.0)
                .padding(.vertical, 16.0)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 24.0, height: 24.0)
                            .frame(width: 50.0, height: 50.0, alignment: .leading)
                    }
                }
            }
        }
    }
}

fileprivate struct OnboardInfoRowView: View {
    let onboardInfo: Onboard

    var body: some View {
        GridRow {
            onboardInfo.icon
                .resizable()
                .scaledToFit()
                .frame(width: 48.0, height: 48.0)

            VStack(alignment: .leading, spacing: 4.0) {
                Text(onboardInfo.title)

                Text(onboardInfo.description)
            }
        }
    }
}

#Preview {
    OnboardView()
}
