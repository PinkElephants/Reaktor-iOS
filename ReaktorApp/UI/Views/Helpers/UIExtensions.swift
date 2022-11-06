//
//  UIExtensions.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import SwiftUI

extension LinearGradient {
    static let heale = LinearGradient(gradient: Gradient(colors: [.white, .accentColor.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
    static let spotify = LinearGradient(gradient: Gradient(colors: [.white, Color("SpotifyGreen").opacity(0.5)]), startPoint: .top, endPoint: .bottom)
    static let healthRed = LinearGradient(gradient: Gradient(colors: [.white, Color("HealthRed").opacity(0.5)]), startPoint: .top, endPoint: .bottom)
    static let twitterBlue = LinearGradient(gradient: Gradient(colors: [.white, Color("TwitterBlue").opacity(0.5)]), startPoint: .top, endPoint: .bottom)

    static func withColor(_ color: Color) -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [.white, color.opacity(0.3)]), startPoint: .init(x: 0.5, y: 0.3), endPoint: .bottom)
    }
}
