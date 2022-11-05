//
//  BarChart.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import SwiftUI
import Charts

struct BarChart: View {

    private let sadness: [SadnessChart]

    init(sadness: [SadnessChart]) {
        self.sadness = sadness
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            GroupBox("Your daily mood") {
                Chart {
                    ForEach(sadness) {
                        LineMark(
                            x: .value("Day", $0.dateString),
                            y: .value("Sad", $0.sadness_indes)
                        )
                        .foregroundStyle(by: .value("Type", "\($0.type)"))
                    }
                }
                .frame(height: 250)
            }.backgroundStyle(.white)
        }
    }
}

struct BarChart_Previews: PreviewProvider {

    private static var sads: [SadnessChart] {
        guard let url = Bundle(for: MoodsApi.self).url(forResource: "happiesSaddies", withExtension: "json") else {
            return []
        }
        let data = try! Data(contentsOf: url)

        let decodedData = try! CustomDecoder().decode([SadnessChart].self, from: data)

        return decodedData
    }
    static var previews: some View {
        BarChart(sadness: sads)
    }
}
