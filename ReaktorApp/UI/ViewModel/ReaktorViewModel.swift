import Foundation
import SwiftUI

final class ReaktorViewModel: ObservableObject {

    @Published var state: VMState = .loading

    var graphs: [Graph]
    private var api: API

    init(api: API = MoodsApi(),
         graphs: [Graph] = []) {
        self.api = api
        self.graphs = graphs
    }

    func onAppear() {
        guard !isRunningOnPreviews() else {
            return
        }

        if state == .loading {
            Task {
                await fetchGraphs()
            }
        }
    }

    @MainActor
    func fetchGraphs() async {

        self.state = .completed
        return

        do {
            let graphs: [Graph] = try await api.request(ReaktorListRequest(), method: .GET)
            self.graphs = graphs
            self.state = .completed
        } catch {
            self.graphs = []
            self.state = .error(error.localizedDescription)
        }
    }
}
