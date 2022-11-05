//
//  DetailsViewModel.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import Foundation
import SwiftUI
import HealthKit

final class DetailsViewModel: ObservableObject {

    @Published var state: VMState = .loading

    var sadness: [SadnessIndex]
    private var api: MoodsApi

    init(api: MoodsApi = MoodsApi(),
         sadness: [SadnessIndex] = []) {
        self.api = api
        self.sadness = sadness
    }

    func onAppear() {
        if state == .loading {
            Task {
                await fetchSadness()
            }
        }
    }

    func fetchSadness() async {
        self.api.getSadnessCarefullyCalculatedByMLGuy { sadness, error in

            DispatchQueue.main.async {
                if let sadness = sadness {
                    self.sadness = sadness.sorted(by: { ind1, ind2 in
                        ind1.dateString > ind2.dateString
                    })
                }
                self.state = .completed
            }
        }
    }
}
