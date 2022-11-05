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
                            let parsedData: [HealthDataQuant] = objects?.enumerated().map { (index, sample) in

                                let quantitySample = sample as! HKQuantitySample
                                let count = quantitySample.quantity.doubleValue(for: HKUnit(from: "count"))

                                let data = HealthDataQuant(id: index, count: Int(count), startDate: quantitySample.startDate, endDate: quantitySample.endDate)

                                return data
                            } ?? []

                            let json = self?.json(from: parsedData)
                        }

                        HealthAccess.shared.getWeeklyRuns { objects, error in

                            let parsedData: [HealthDataQuant] = objects?.enumerated().compactMap { (index, sample) in

                                let quantitySample = sample as! HKQuantitySample
                                let meters = quantitySample.quantity.doubleValue(for: HKUnit(from: "m"))

                                let data = HealthDataQuant(id: index, count: Int(meters), startDate: quantitySample.startDate, endDate: quantitySample.endDate)

                                return meters >= 250 ? data : nil
                            } ?? []
                            let json = self?.json(from: parsedData)
                        }

                        HealthAccess.shared.getWeeklyMeanHR { objects, error in
                            let parsedData: [HealthDataQuant] = objects?.enumerated().map { (index, sample) in

                                let quantitySample = sample as! HKQuantitySample
                                let count = quantitySample.quantity.doubleValue(for: HKUnit(from: "count/min"))

                                let data = HealthDataQuant(id: index, count: Int(count), startDate: quantitySample.startDate, endDate: quantitySample.endDate)

                                return data
                            } ?? []
                            let json = self?.json(from: parsedData)
                        }
                        HealthAccess.shared.getWeeklyRestingHR { objects, error in
                            let parsedData: [HealthDataQuant] = objects?.enumerated().map { (index, sample) in

                                let quantitySample = sample as! HKQuantitySample
                                let count = quantitySample.quantity.doubleValue(for: HKUnit(from: "count/min"))

                                let data = HealthDataQuant(id: index, count: Int(count), startDate: quantitySample.startDate, endDate: quantitySample.endDate)

                                return data
                            } ?? []
                            let json = self?.json(from: parsedData)
                        }
                    }
                }
            }
        }
    }

    func json(from object: Codable) -> String? {
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted , .sortedKeys]
        enc.dateEncodingStrategy = .iso8601
        if let data = try? enc.encode(object) {
            let jsonString = String(data: data, encoding: .utf8)
            return jsonString
        } else {
            return nil
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
