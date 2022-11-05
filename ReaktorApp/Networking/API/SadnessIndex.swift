//
//  SadnessIndex.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import Foundation
import Charts

struct SadnessIndex: Codable, Identifiable, Hashable {

    let id: Int
    let happyness_index: Double
    let major_sum: Int
    let minor_sum: Int
    let played_at: Date
    let sadness_indes: Double
    let unconf_sum: Int
    let user_uuid: String

    var happinessString: String { String(format: "%.1f", happyness_index)  }
    var sadnessString: String { String(format: "%.1f", sadness_indes)  }
    var dateString: String { played_at.toString(dateFormat: "dd MMM") }
    var musicKey: String { major_sum >= minor_sum ? "major" : "minor" }
}

struct SadnessChart: Codable, Identifiable, Hashable {

    let id: Int
    let major_sum: Int
    let minor_sum: Int
    let played_at: Date
    let sadness_indes: Double
    let unconf_sum: Int
    let user_uuid: String
    let type: String

    var dateString: String { played_at.toString(dateFormat: "dd MMM") }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
