//
//  UserHeader.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import SwiftUI

struct UserHeader: View {
    var body: some View {
        HStack(spacing: 16) {
            Image("UserLogo")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 2))
            Text("Art Zverkovskiy").font(.title).bold()
            Spacer()
        }
    }
}

struct UserHeader_Previews: PreviewProvider {
    static var previews: some View {
        UserHeader()
    }
}
