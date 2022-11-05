//
//  SpotifyWarning.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import SwiftUI

struct SpotifyWarning: View {
    var body: some View {
        HStack(spacing: 16) {
            Image("Spotify")
                .resizable()
                .frame(width: 32, height: 32)
                .clipShape(Circle())
            Text(Strings.enableSpotify.rawValue).bold()
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: .accentColor.opacity(0.3), radius: 4)
    }
}

struct SpotifyWarning_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyWarning()
    }
}
