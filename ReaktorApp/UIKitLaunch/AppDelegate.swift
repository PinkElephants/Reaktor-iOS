//
//  AppDelegate.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 04/11/22.
//

import UIKit
import HealthKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let healthStore: HKHealthStore

    // MARK: - Initializers

    override init() {
        guard HKHealthStore.isHealthDataAvailable() else { fatalError("This app requires a device that supports HealthKit") }

        healthStore = HKHealthStore()
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // Set the health store where appropriate.
        window?.rootViewController?.enumerateHierarchy { viewController in
            print(viewController)
//            guard var healthStoreContainer = viewController as? HealthStoreContainer else { return }
//            healthStoreContainer.healthStore = healthStore
        }

        // Create the heart rate and heartbeat type identifiers.
        let sampleTypes = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!,
                               HKObjectType.quantityType(forIdentifier: .restingHeartRate)!,
                               HKSeriesType.heartbeat(),
                               HKQuantityType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!])

        // Request permission to read and write heart rate and heartbeat data.
        healthStore.requestAuthorization(toShare: nil, read: sampleTypes) { (success, error) in
            print("Request Authorization -- Success: ", success, " Error: ", error ?? "nil")
            // Handle authorization errors here.
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

extension UIViewController {
    // Executes the provided closure on the current view controller
    // and on all of its descendants in the view controller hierarchy.
    func enumerateHierarchy(_ closure: (UIViewController) -> Void) {
        closure(self)

        for child in children {
            child.enumerateHierarchy(closure)
        }
    }
}

