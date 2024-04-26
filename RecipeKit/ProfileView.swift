//
//  ProfileView.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 4/17/24.
//

import SwiftUI

struct ProfileView: View {
//    let profile: V0_Profile

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
                        Text("First name")
                        Text("Last name")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16.0)
                .background(.gray)
                .clipShape(.rect(cornerRadius: 12.0))
            }
            .padding(.horizontal, 16.0)
            .padding(.vertical, 12.0)
        }
    }
}

#Preview {
    ProfileView()
//    ProfileView(profile: V0_Profile(record: ))
}
