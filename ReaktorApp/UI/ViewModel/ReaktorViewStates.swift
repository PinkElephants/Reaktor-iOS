//
//  ReaktorList.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 04/11/22.
//

import Foundation
import SwiftUI

struct ReaktorList: View {

    @Binding var searchText: String
    var graphs: [Graph]

    var body: some View {
        List {
            Section {
                ForEach(graphs) { graph in
                    GraphRow(
                        text: ""
                    )
                }
            } header: {
                searchHeader
            }
        }
        .listStyle(PlainListStyle())
        .frame(maxHeight: .infinity)
    }

    var searchHeader: some View {
        TextField("Search", text: $searchText)
            .contentShape(Rectangle())
            .font(.callout)
            .frame(minHeight: 40)
    }
}
