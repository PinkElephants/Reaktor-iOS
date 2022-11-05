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
}
