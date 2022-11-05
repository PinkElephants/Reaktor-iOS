//
//  MainView.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        TabView {
            ReaktorContainer(viewModel: ReaktorViewModel())
                .padding([.bottom], 16)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            DetailsContainer(viewModel: DetailsViewModel())
                .padding([.bottom], 16)
                .tabItem {
                    Label("Details", systemImage: "list.dash")
                }
            SettingsContainer()
                .padding([.bottom], 16)
                .tabItem {
                    Label("User profile", systemImage: "person.crop.circle")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        return Group {
            MainView()
        }
    }
}
