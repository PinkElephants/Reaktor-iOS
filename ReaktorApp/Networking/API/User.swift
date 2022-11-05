//
//  User.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import Foundation

struct User: Codable, Identifiable {

    let id: Int
    let uuid: String
    let finish_job: Date
    let start_job: Date
}

extension User {
    static let example = User(id: 1, uuid: "example", finish_job: Date(timeIntervalSinceNow: 3600), start_job: Date())

    static var UserID: String {

        let userDefaults = UserDefaults.standard

        // Read Boolean
        if let user = userDefaults.string(forKey: "userUUID") {
            return user
        } else {
            let uuid = UUID().uuidString
            userDefaults.set(uuid, forKey: "userUUID")
            return uuid
        }
    }
}
