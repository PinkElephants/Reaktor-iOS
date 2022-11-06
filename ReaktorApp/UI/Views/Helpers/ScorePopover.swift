//
//  ScorePopover.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 06/11/2022.
//

import SwiftUI

struct ScorePopover: View {
    var body: some View {
        LinearGradient.withColor(.yellow).overlay {
            VStack(alignment: .leading, spacing: 16) {
                Spacer().frame(height: 128)
                HStack {
                    Text(Strings.yourScoreHeader.rawValue).font(.largeTitle).bold()
                    Spacer()
                }
                HStack {
                    Text(Strings.yourScoreText7.rawValue).font(.title3).bold()
                    Spacer()
                }
                Spacer()
            }.padding([.horizontal], 16)
        }
    }
}

struct ScorePopover_Previews: PreviewProvider {
    static var previews: some View {
        ScorePopover()
    }
}
