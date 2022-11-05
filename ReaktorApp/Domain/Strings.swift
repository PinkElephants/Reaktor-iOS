//
//  Strings.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import Foundation

enum Strings: String {
    case enableSpotify = "To improve score accuracy please sign in to Spotify in Settings"
    case accessSpotify = "Spotify access"
    case accessHealth = "Apple Health access"
    case twitterUsername = "Your Twitter username"
    case healthWarning = "You won't be able to record your score without Apple Health access, but you will still be able to access historical data"
    case deleteProfile = "Delete user profile"


    case introMainHeader = "Hi, my name is Heale. I am your whale of health."
    case introMainText = "I want to help you to track your health condition. Based on some of your metrics I will calculate the Score and give you some recommendations on how to improve your health condition. For this purpose I need some permissions. Click \"Next\" and I will walk you through"
    case introHealthHeader = "First I will need the access to Apple Health."
    case introHealthText = "I will use your data about your physical activities, heart rate and sleeping behaviours."
    case introSpotifyHeader = "Looks weird that I ask you for your Spotify account, right?"
    case introSpotifyText = "But according to some researches your music is telling about you way more than you think. If you provide me the access to your spotify account, I will be analyzing last 50 tracks you have listened and the results will also be a part of your health score"
    case introTwitterHeader = "Also, I can analyze what you write on Twitter"
    case introTwitterText = "With a help of Natural Language Processing and Sentiment Analysis I will be able to track some changes in your mood and use it in the Health Score as well"
}
