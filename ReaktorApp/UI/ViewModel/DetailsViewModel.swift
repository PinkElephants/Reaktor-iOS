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
    private var api: MoodsApi

    init(api: MoodsApi = MoodsApi()) {
        self.api = api
    }

    func onAppear() {
        if state == .loading {
            Task {
                fetchDetails()
            }
        }
    }

    func fetchDetails() {}
}
