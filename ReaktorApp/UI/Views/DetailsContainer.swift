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
                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("You played a lot of wonderful music and had enough activity data for us to conclude the following:")
                                .padding([.bottom], 16)
                            ForEach(viewModel.sadness) { sadness in
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text("Music played on").bold()
                                        Text("\(sadness.dateString)").bold().foregroundColor(Color("HealthRed"))
                                        Text("produced:")
                                    }.padding([.bottom], 4)
                                    HStack {
                                        Text("Happiness:").bold()
                                        Text("\(sadness.happinessString)")
                                        Spacer()
                                        Text("Sadness:").bold()
                                        Text("\(sadness.sadnessString)")
                                    }
                                    Text("And was mostly in \(sadness.musicKey) key")
                                }
                                .padding(12)
                                .background(Color.white)
                                .cornerRadius(8)
                                .padding([.bottom], 8)
                            }
                            Spacer()
                        }
                        .padding([.leading], 16)
                        .padding([.trailing, .top, .bottom], 32)
                    }.padding([.bottom], 1)
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
