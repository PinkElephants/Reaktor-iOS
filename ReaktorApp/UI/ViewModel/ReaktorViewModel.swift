import Foundation
import SwiftUI

final class ReaktorViewModel: ObservableObject {

    @Published var state: VMState = .loading

    var sadness: [SadnessChart]
    private var api: MoodsApi

    init(api: MoodsApi = MoodsApi(),
         sadness: [SadnessChart] = []) {
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
        self.api.getChartCarefullyCalculatedByMLGuy { sadness, error in

            DispatchQueue.main.async {
                if let sadness = sadness {
                    self.sadness = sadness
                }
                self.state = .completed
            }
        }
    }
}
