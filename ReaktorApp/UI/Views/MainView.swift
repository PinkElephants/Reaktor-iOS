//
//  MainView.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import SwiftUI

struct MainView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var selection = 0
    @State var spotifyAccess = false

    var body: some View {

        TabView(selection: $selection) {
            ReaktorContainer(spotifyAccess: _spotifyAccess, tabSelection: _selection)
                .padding([.bottom], 16)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }.tag(0)

            DetailsContainer(viewModel: DetailsViewModel())
                .padding([.bottom], 16)
                .tabItem {
                    Label("Details", systemImage: "list.dash")
                }.tag(1)
            SettingsContainer(spotifyAccess: _spotifyAccess)
                .padding([.bottom], 16)
                .tabItem {
                    Label("User profile", systemImage: "person.crop.circle")
                }.tag(2)
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        return Group {
            MainView()
        }
    }
}
