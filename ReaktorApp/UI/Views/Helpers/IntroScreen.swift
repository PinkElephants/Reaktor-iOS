//
//  IntroScreen.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import SwiftUI

struct IntroScreen: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    enum IntroType {
        case main
        case health
        case spotify
        case twitter

        func gradient() -> LinearGradient {
            switch self {
            case .main:
                return LinearGradient.heale
            case .health:
                return LinearGradient.healthRed
            case .spotify:
                return LinearGradient.spotify
            case .twitter:
                return LinearGradient.twitterBlue
            }
        }

        func foregroundColor() -> Color {
            switch self {
            case .main:
                return .accentColor
            case .health:
                return Color("HealthRed")
            case .spotify:
                return Color("SpotifyGreen")
            case .twitter:
                return Color("TwitterBlue")
            }
        }

        func headerText() -> String {
            switch self {
            case .main:
                return Strings.introMainHeader.rawValue
            case .health:
                return Strings.introHealthHeader.rawValue
            case .spotify:
                return Strings.introSpotifyHeader.rawValue
            case .twitter:
                return Strings.introTwitterHeader.rawValue
            }
        }

        func mainText() -> String {
            switch self {
            case .main:
                return Strings.introMainText.rawValue
            case .health:
                return Strings.introHealthText.rawValue
            case .spotify:
                return Strings.introSpotifyText.rawValue
            case .twitter:
                return Strings.introTwitterText.rawValue
            }
        }

        func destination() -> AnyView {
            switch self {
            case .main:
                return AnyView(IntroScreen(type: .health))
            case .health:
                return AnyView(IntroScreen(type: .spotify))
            case .spotify:
                return AnyView(IntroScreen(type: .twitter))
            case .twitter:
                return AnyView(MainView())
            }
        }

        func logo() -> AnyView {
            switch self {
            case .main:
                return AnyView(Image("HealeTransparent").resizable().frame(width: 250, height: 250).opacity(0.2))
            case .health:
                return AnyView(Image("HealthLogo").resizable().frame(width: 270, height: 230).opacity(0.3))
            case .spotify:
                return AnyView(Image("Spotify").resizable().frame(width: 250, height: 250).opacity(0.3))
            case .twitter:
                return AnyView(Image("TwitterLogo").resizable().frame(width: 250, height: 250).opacity(0.6))
            }
        }
    }

    private var type: IntroType

    init(type: IntroType) {
        self.type = type
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                ZStack {
                    type.logo()
                    type.gradient().ignoresSafeArea().overlay(
                        VStack(alignment: .leading, spacing: 32) {
                            Text(self.type.headerText())
                                .font(.title).bold()
                                .foregroundColor(.accentColor)
                                .padding([.top], 64)
                            Text(self.type.mainText()).font(.title3).bold().foregroundColor(.accentColor)
                            Spacer()
                            HStack {
                                Spacer()
                                NavigationLink(destination: type.destination) {
                                    Text(type == .twitter ? "Go to app" : "Next")
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding([.horizontal], 24)
                                        .padding([.vertical], 8)
                                        .overlay(RoundedRectangle(cornerSize: .init(width: 16, height: 16)).stroke(Color.white, lineWidth: 2))
                                }

                            }
                        }
                        .padding([.leading], 16)
                        .padding([.trailing, .top, .bottom], 32))
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct IntroScreen_Previews: PreviewProvider {
    static var previews: some View {
        return Group {
            IntroScreen(type: .main).previewDisplayName("Main")
            IntroScreen(type: .health).previewDisplayName("Health")
            IntroScreen(type: .spotify).previewDisplayName("Spotify")
            IntroScreen(type: .twitter).previewDisplayName("Twitter")
        }
    }
}
