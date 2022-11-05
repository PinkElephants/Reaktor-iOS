//
//  ScoreHeader.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import SwiftUI

struct ScoreHeader: View {
    private var text: String
    private var color: Color

    init(score: Int = 7) {
        self.text = "\(score)"
        switch score {
        case 0..<3:
            self.color = .red
        case 3..<6:
            self.color = .orange
        case 6..<8:
            self.color = .yellow
        default:
            self.color = .green
        }
    }

    var body: some View {
        HStack(spacing: 16) {
            Text("Your wellbeing score is:").font(.title2).bold()
            Circle().foregroundColor(self.color)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 2))
                .overlay(Text(text).font(.largeTitle).bold())
        }.padding([.vertical], 8)
    }
}

struct ScoreHeader_Previews: PreviewProvider {
    static var previews: some View {
        ScoreHeader()
    }
}
