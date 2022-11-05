import UIKit
import SwiftUI
import HealthKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    override init() {
        guard HKHealthStore.isHealthDataAvailable() else { fatalError("This app requires a device that supports HealthKit") }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let hostController = UIHostingController(rootView: MainView())

        window.rootViewController = hostController

        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

