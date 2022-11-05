//
//  HealthDataQuant.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import Foundation

struct HealthDataQuant: Codable, Identifiable {
    let id: Int
    let count: Int
    let startDate: Date
    let endDate: Date
}
