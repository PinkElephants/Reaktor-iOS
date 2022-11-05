//
//  ReaktorList.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 04/11/22.
//

import Foundation
import SwiftUI

struct ReaktorList: View {
    
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
                // None?
            }
        }
        .listStyle(.inset)
        .frame(maxHeight: .infinity)
    }
}

struct ReaktorList_Previews: PreviewProvider {

    static var previews: some View {
        return Group {
            ReaktorList(graphs: [])
        }
    }
}
