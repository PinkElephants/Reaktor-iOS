//
//  GraphRow.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 04/11/22.
//

import Foundation
import SwiftUI

struct GraphRow: View {

    var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .accessibilityIdentifier("text")
            
            HStack {
                Image(systemName: "checkmark.seal")
                    .accessibilityIdentifier("checkmarkIcon")
            }
        }
    }
}
