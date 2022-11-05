//
//  SettingsViewModel.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import Foundation
import SwiftUI
import HealthKit

final class SettingsViewModel: ObservableObject {

    @Published var state: VMState = .loading
    @Published var spotifyState: Bool = false
    @Published var healthState: Bool = false

    var user: User
    private var api: MoodsApi

    init(api: MoodsApi = MoodsApi(), user: User = User.example) {
        self.api = api
        self.user = user
    }

    func onAppear() {
        if state == .loading {
            Task {
                fetchUser()
                HealthAccess.shared.checkAccess { [weak self] healthAuthorization in
                    DispatchQueue.main.async { [weak self] in
                        self?.healthState = healthAuthorization

                        HealthAccess.shared.getWeeklySteps { objects, error in
                            let parsedData: [String] = objects?.compactMap { sample in

                                let quantitySample = sample as! HKQuantitySample
                                let data: String = """
                                { "count": \(quantitySample.quantity), "start": \(quantitySample.startDate), "end": \(quantitySample.endDate) }
                                """

                                return data
                            } ?? []
                            print(objects)
                        }

                        HealthAccess.shared.getWeeklyRuns { objects, error in
                            let longWalkRuns: [HKQuantitySample] = objects?.compactMap {
                                let quantitySample = $0 as! HKQuantitySample
                                let meters = quantitySample.quantity.doubleValue(for: HKUnit(from: "m"))
                                return meters >= 500 ? quantitySample : nil
                            } ?? []
                            print(objects)
                        }

                        HealthAccess.shared.getWeeklyMeanHR { objects, error in
                            print(objects)
                        }
                        HealthAccess.shared.getWeeklyRestingHR { objects, error in
                            let number1 = objects![0].quantity.doubleValue(for: HKUnit(from: "count/min"))
                            print(objects)
                        }
                    }
                }
            }
        }
    }

    func fetchUser() {

        api.getUser { user, error in
            if let user = user {
                DispatchQueue.main.async {
                    self.user = user
                    self.state = .completed
                }
            } else {
                // Create user
                self.api.postUser { user, error in
                    DispatchQueue.main.async {
                        if let user = user {
                            self.user = user
                            self.state = .completed
                        } else {
                            self.user = .example
                            self.state = .error(error?.localizedDescription ?? "")
                        }
                    }
                }
            }
        }
    }
}
