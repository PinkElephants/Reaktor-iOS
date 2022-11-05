//
//  HealthAccess.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import Foundation
import HealthKit

final class HealthAccess {

    static let shared = HealthAccess()

    private let healthStore: HKHealthStore = HKHealthStore()

    func checkAccess(_ completion: @escaping (_ success: Bool) -> Void) {
        DispatchQueue.main.async { [weak self] in

            // Request permission to read and write heart rate and heartbeat data.
            self?.healthStore.requestAuthorization(toShare: nil, read: Set(HealthAccess.readDataTypes)) { (success, error) in
                print("Request Authorization -- Success: ", success, " Error: ", error ?? "nil")
                completion(success)
            }
        }
    }
}

// MARK: - Get historical data

extension HealthAccess {

    func getWeeklyRuns(completion: (([AnyObject]?, NSError?) -> Void)!) {

            let endDate = NSDate()
            let startDate = NSCalendar.current.date(byAdding: .month, value: -1, to: endDate as Date)

            let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)
            let predicate =  HKQuery.predicateForSamples(withStart: startDate, end: endDate as Date, options: [])

            let sampleQuery = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) {
                (sampleQuery, results, error ) -> Void in

                if let queryError = error {
                    completion?(nil, queryError as NSError?)
                    return
                }

                if completion != nil {
                    completion(results, nil)
                }
            }

            self.healthStore.execute(sampleQuery)

        }

    func getWeeklySteps(completion: (([AnyObject]?, NSError?) -> Void)!) {

            let endDate = NSDate()
            let startDate = NSCalendar.current.date(byAdding: .weekOfMonth, value: -1, to: endDate as Date)

            let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
            let predicate =  HKQuery.predicateForSamples(withStart: startDate, end: endDate as Date, options: [])

            let sampleQuery = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) {
                (sampleQuery, results, error ) -> Void in

                if let queryError = error {
                    completion?(nil, queryError as NSError?)
                    return
                }

                if completion != nil {
                    completion(results, nil)
                }
            }

            self.healthStore.execute(sampleQuery)

        }

    func getWeeklyRestingHR(completion: (([AnyObject]?, NSError?) -> Void)!) {

            let endDate = NSDate()
            let startDate = NSCalendar.current.date(byAdding: .weekOfMonth, value: -1, to: endDate as Date)

            let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.restingHeartRate)
            let predicate =  HKQuery.predicateForSamples(withStart: startDate, end: endDate as Date, options: [])

            let sampleQuery = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) {
                (sampleQuery, results, error ) -> Void in

                if let queryError = error {
                    completion?(nil, queryError as NSError?)
                    return
                }

                if completion != nil {
                    completion(results, nil)
                }
            }

            self.healthStore.execute(sampleQuery)
        }

    func getWeeklyMeanHR(completion: (([AnyObject]?, NSError?) -> Void)!) {

            let endDate = NSDate()
            let startDate = NSCalendar.current.date(byAdding: .weekOfMonth, value: -1, to: endDate as Date)

            let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)
            let predicate =  HKQuery.predicateForSamples(withStart: startDate, end: endDate as Date, options: [])

            let sampleQuery = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) {
                (sampleQuery, results, error ) -> Void in

                if let queryError = error {
                    completion?(nil, queryError as NSError?)
                    return
                }

                if completion != nil {
                    completion(results, nil)
                }
            }

            self.healthStore.execute(sampleQuery)
        }
}

// MARK: - Useful stuff

extension HealthAccess {

    static var readDataTypes: [HKSampleType] {
        return allHealthDataTypes
    }

    static var shareDataTypes: [HKSampleType] {
        return allHealthDataTypes
    }

    private static var allHealthDataTypes: [HKSampleType] {
        let typeIdentifiers: [String] = [
            HKObjectType.quantityType(forIdentifier: .heartRate)!.identifier,
            HKSeriesType.heartbeat().identifier,
            HKQuantityType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!.identifier,
            HKQuantityTypeIdentifier.restingHeartRate.rawValue,
            HKQuantityTypeIdentifier.heartRate.rawValue,
            HKQuantityTypeIdentifier.heartRateVariabilitySDNN.rawValue,
            HKQuantityTypeIdentifier.walkingHeartRateAverage.rawValue,
            HKQuantityTypeIdentifier.stepCount.rawValue,
            HKQuantityTypeIdentifier.distanceWalkingRunning.rawValue,
            HKQuantityTypeIdentifier.sixMinuteWalkTestDistance.rawValue,
            HKObjectType.workoutType().identifier,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!.identifier,
            HKObjectType.activitySummaryType().identifier
        ]

        return typeIdentifiers.compactMap { getSampleType(for: $0) }
    }

    // MARK: Helper functions

    static func getSampleType(for identifier: String) -> HKSampleType? {
        if let quantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier(rawValue: identifier)) {
            return quantityType
        }

        if let categoryType = HKCategoryType.categoryType(forIdentifier: HKCategoryTypeIdentifier(rawValue: identifier)) {
            return categoryType
        }

        return nil
    }
}
