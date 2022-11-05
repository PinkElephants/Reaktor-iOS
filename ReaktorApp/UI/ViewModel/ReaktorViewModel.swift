import Foundation
import SwiftUI

extension ReaktorViewModel {
    enum State: Equatable {
        case loading
        case completed
        case error(String)
    }
}

final class ReaktorViewModel: ObservableObject {
    /// The displayable values
    var displayableReaktor: [Graph] {
        searchTerm.isEmpty ? graphs : graphs
            .lazy
            .filter { $0.text.localizedCaseInsensitiveContains(searchTerm) }
    }

    @Published var state: State = .loading
    @Published var searchTerm: String = ""

    private var graphs: [Graph]
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
                await fetchFacts()
            }
        }
    }

    @MainActor
    func fetchFacts() async {
        do {
            let facts: [Graph] = try await api.request(ReaktorListRequest(), method: .GET)
            self.graphs = facts
            self.state = .completed
        } catch {
            self.graphs = []
            self.state = .error(error.localizedDescription)
        }
    }
}
