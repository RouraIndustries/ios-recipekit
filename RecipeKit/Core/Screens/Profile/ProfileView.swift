//
//  ProfileView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/17/24.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @Environment(\.cloudKitManager) private var cloudKitManager
    @State private var viewModel = ViewModel()

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    PhotosPicker(selection: $viewModel.photosPickerItem, matching: .images, photoLibrary: .shared()) {
                        Image(uiImage: viewModel.avatar)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 96, height: 96)
                            .clipShape(.circle)
                            .overlay(alignment: .bottom) {
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 14, height: 14)
                                    .offset(y: -4.0)
                            }
                    }
                    .buttonStyle(.plain)

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
