//
//  ProfileView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/17/24.
//

import SwiftUI
import PhotosUI
import Tuxedo

enum FocusedField {
    case firstName, lastName, username, bio
}

struct ProfileView: View {
    static let tag: String? = String(describing: Self.self)
    @Environment(\.experimentationFacade) private var experimentationFacade
    @Environment(\.cloudKitManager) private var cloudKitManager
    @FocusState private var focusedField: FocusedField?

    @State private var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12.0) {
                    HStack(spacing: 12.0) {
                        VStack(spacing: 12.0) {
                            HStack(alignment: .top) {
                                Button {} label: {
                                    Image(systemName: "rosette")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24.0, height: 24.0)
                                        .foregroundStyle(.midnightPrimary)
                                }
                                .frame(width: 44.0, height: 44.0)
                                .opacity(experimentationFacade.enableAwardsView != .variant ? 1 : 0)

                                Spacer()

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
                                                .foregroundStyle(.whitePrimary)
                                        }
                                }
                                .buttonStyle(.plain)

                                Spacer()

                                Button { viewModel.showSettingsView.toggle() } label: {
                                    Image(systemName: "gear")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24.0, height: 24.0)
                                        .foregroundStyle(.midnightPrimary)
                                }
                                .frame(width: 44.0, height: 44.0)
                                .opacity(experimentationFacade.enableSettingsView ? 1 : 0)
                                .sheet(isPresented: $viewModel.showSettingsView) {
                                    SettingsView()
                                }
                            }

                            VStack(spacing: .zero) {
                                TextField("First name", text: $viewModel.firstName)
                                    .textContentType(.givenName)
                                    .focused($focusedField, equals: .firstName)
                                    .tuxedoFont(.h5Bold)
                                    .foregroundStyle(.foregroundPrimary)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.75)

                                TextField("Last name", text: $viewModel.lastName)
                                    .textContentType(.familyName)
                                    .focused($focusedField, equals: .lastName)
                                    .tuxedoFont(.h5Bold)
                                    .foregroundStyle(.foregroundPrimary)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.75)

                                TextField("Username", text: $viewModel.username)
                                    .textContentType(.organizationName)
                                    .focused($focusedField, equals: .username)
                                    .tuxedoFont(.h5Light)
                                    .foregroundStyle(.foregroundPrimary)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.75)
                            }
                        }
                    }
                    .padding(.horizontal, 16.0)
                    .padding(.vertical, 12.0)
                    .background(.backgroundRecessed)
                    .clipShape(.rect(cornerRadius: 16.0))

                    HStack(alignment: .bottom, spacing: 6.0) {
                        TextField("Bio", text: $viewModel.bio, axis: .vertical)
                            .focused($focusedField, equals: .bio)
                            .tuxedoFont(.h5Light)
                            .foregroundStyle(.foregroundPrimary)
                            .lineLimit(4...6)
                            .frame(maxWidth: .infinity)

                        Text("\(viewModel.charactersRemainCount)")
                            .tuxedoFont(.captionExtraBold)
                            .foregroundStyle(viewModel.bioWithinCountThresholdColor)
                    }
                    .padding(.horizontal, 12.0)
                    .padding(.vertical, 8.0)
                    .background(.backgroundRaised)
                    .clipShape(.rect(cornerRadius: 8.0))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke(.foregroundDisabled, lineWidth: 1.0)
                    }
                }
                .scrollTargetLayout()
            }
            .contentMargins(.horizontal, 16.0, for: .scrollContent)
            .contentMargins(.vertical, 12.0, for: .scrollContent)
            .background(.backgroundPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Profile")
                        .tuxedoFont(.h4)
                        .foregroundStyle(.foregroundPrimary)
                }

                ToolbarItem(placement: .keyboard) {
                    Button { keyboardToolbarAction() } label: {
                        Text(focusedField == .bio ? "Done" : "Next")
                            .tuxedoFont(.bodyExtraBold)
                            .foregroundStyle(.midnightPrimary)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .task {
                viewModel.cloudKitManager = cloudKitManager
                await viewModel.fetchProfile()
            }
            .scrollDismissesKeyboard(.interactively)
            .overlay { if viewModel.isLoading { LoadingView() }}
            .onSubmit { keyboardToolbarAction() }
            .alert($viewModel.error)
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: .zero) {
                    Group {
                        Text("Joined:")
                        + Text (" ") +
                        Text("\(viewModel.joinedOnDate.formatted(.dateTime.day().month().year()))")
                            .tuxedoFont(.captionBold)
                            .foregroundStyle(.foregroundPrimary)
                    }
                    .tuxedoFont(.caption)
                    .foregroundStyle(.foregroundSecondary)

                    Button { viewModel.buttonAction() } label: {
                        Text(viewModel.buttonTitle)
                            .tuxedoFont(.h5Bold)
                            .foregroundStyle(.whitePrimary)
                            .frame(width: 280, height: 50)
                            .background(.midnightPrimary)
                            .clipShape(.rect(cornerRadius: 8.0))
                    }
                    .padding(.vertical, 12.0)
                    .frame(maxWidth: .infinity)
                    .applySafeAreaGradient()
                }
            }
        }
    }

    func keyboardToolbarAction() {
        switch focusedField {
        case .firstName: focusedField = .lastName
        case .lastName: focusedField = .username
        case .username: focusedField = .bio
        case .bio: focusedField = nil
        case .none: break
        }
    }
}

#Preview {
    ProfileView()
}
