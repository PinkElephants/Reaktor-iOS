//
//  SettingsContainer.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import SwiftUI

struct SettingsContainer: View {

    @State var spotifyAccess: Bool = false

    @StateObject var viewModel: SettingsViewModel = .init()

    init(spotifyAccess: State<Bool>) {
        self._spotifyAccess = spotifyAccess
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                LinearGradient.heale.overlay(
                    VStack(alignment: .center, spacing: 8) {
                        HStack(spacing: 8) {
                            Toggle(isOn: $spotifyAccess) {
                                Text(Strings.accessSpotify.rawValue).bold()
                            }
                        }
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding([.bottom], 8)
                        HStack(spacing: 8) {
                            Toggle(isOn: $viewModel.healthState) {
                                Text(Strings.accessHealth.rawValue).bold()
                            }
                        }
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(8)
                        Text(Strings.healthWarning.rawValue).foregroundColor(.red.opacity(0.7))
                            .padding([.bottom], 16)
                        HStack(spacing: 8) {
                            Text(Strings.twitterUsername.rawValue).bold()
                            Spacer()
                            Text("@zverart").foregroundColor(.blue.opacity(0.7))
                        }
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding([.bottom], 8)
                        Spacer()
                        Text(Strings.deleteProfile.rawValue)
                            .bold()
                            .foregroundColor(.red)
                            .shadow(color: .white.opacity(0.5), radius: 2)
                    }
                        .padding([.leading], 16)
                        .padding([.trailing, .top, .bottom], 32)
                )
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            UserHeader().padding([.top], 64)
                        }
                    }
            }
            .onAppear(perform: viewModel.onAppear)
        }
    }
}

struct SettingsContainer_Previews: PreviewProvider {

    @State static var access: Bool = true

    static var previews: some View {
        SettingsContainer(spotifyAccess: _access)
    }
}
