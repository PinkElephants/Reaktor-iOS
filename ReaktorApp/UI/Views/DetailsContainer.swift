//
//  DetailsContainer.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import SwiftUI

struct DetailsContainer: View {
    @StateObject var viewModel: DetailsViewModel = .init()

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                LinearGradient.heale.overlay(
                    VStack(alignment: .center, spacing: 8) {

                    }
                    .padding([.leading], 16)
                    .padding([.trailing, .top, .bottom], 32)
                )
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HealeHeader(text: "Daily details").padding([.top], 64)
                        }
                    }
            }
            .onAppear(perform: viewModel.onAppear)
        }
    }
}

struct DetailsContainer_Previews: PreviewProvider {
    static var previews: some View {
        DetailsContainer()
    }
}
