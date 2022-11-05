//
//  HealeHeader.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import SwiftUI

struct HealeHeader: View {
    var body: some View {
        HStack(spacing: 16) {
            Image("Heale")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 2))
            Text("Heale.").font(.largeTitle).bold()
            Spacer()
        }
    }
}

struct HealeHeader_Previews: PreviewProvider {
    static var previews: some View {
        HealeHeader()
    }
}
