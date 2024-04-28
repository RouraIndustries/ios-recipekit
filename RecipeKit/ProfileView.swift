//
//  ProfileView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/17/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.cloudKitManager) private var cloudKitManager
    @State private var viewModel = ViewModel()

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 72.0, height: 72.0)
                        .clipShape(.circle)

                    VStack(alignment: .leading) {
                        TextField("First name", text: $viewModel.firstName)
                        TextField("Last name", text: $viewModel.lastName)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16.0)
                .padding(.vertical, 16.0)
                .background(.gray)
                .clipShape(.rect(cornerRadius: 12.0))
            }
            .padding(.horizontal, 16.0)
            .padding(.vertical, 12.0)
        }
        .task {
            viewModel.cloudKitManager = cloudKitManager
            await viewModel.fetchProfile()
        }
        .scrollDismissesKeyboard(.interactively)
        .overlay { if viewModel.isLoading { LoadingView() }}
        .safeAreaInset(edge: .bottom) {
            Button { viewModel.buttonAction() } label: {
                Text(viewModel.buttonTitle)
                //                    .tuxedoFont(.h5Bold)
                    .foregroundStyle(.white)
                    .frame(width: 280, height: 50)
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: 8.0))
            }
            .padding(.vertical, 12.0)
            .frame(maxWidth: .infinity)
            .applySafeAreaGradient()
        }
    }
}

#Preview {
    ProfileView()
//    ProfileView(profile: V0_Profile(record: ))
}
