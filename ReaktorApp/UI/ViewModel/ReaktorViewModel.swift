import Foundation
import SwiftUI

final class ReaktorViewModel: ObservableObject {

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
                    self.sadness = sadness
                }
                self.state = .completed
            }
        }
    }
}
