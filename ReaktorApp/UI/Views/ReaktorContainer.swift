import Foundation
import SwiftUI

/// The container represents the entry point for our interface.
///
/// The viewModel works with a `State`, and the interface becomes a simple switch or function on
/// the `@published state`.
///
struct ReaktorContainer: View {

    @StateObject var viewModel: ReaktorViewModel = .init()

    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                    case .loading:
                        ProgressView()
                            .navigationTitle(Text("Loading!"))
                    case .completed:
                        ReaktorList(
                            searchText: $viewModel.searchTerm,
                            graphs: viewModel.displayableReaktor
                        )
                        .navigationTitle(Text("Cat Facts!"))
                    case .error(let reason):
                        ErrorPage(errorReason: reason) {
                            Task {
                                await viewModel.fetchFacts()
                            }
                        }.navigationTitle(Text("Oh No!"))
                }
            }
            .onAppear(perform: viewModel.onAppear)
        }
    }
}

struct ReaktorContainer_Previews: PreviewProvider {

    static var viewModelWithContent: ReaktorViewModel {
        let vm = ReaktorViewModel(graphs: [])
        vm.state = .completed
        return vm
    }

    static var viewModelWithLoading: ReaktorViewModel {
        let vm = ReaktorViewModel()
        vm.state = .loading
        return vm
    }

    static var viewModelWithError: ReaktorViewModel  {
        let vm = ReaktorViewModel()
        vm.state = .error("Loading error")
        return vm
    }

    static var previews: some View {
        return Group {
            ReaktorContainer(viewModel: viewModelWithContent)
                .previewDisplayName("Content State")

            ReaktorContainer(viewModel: viewModelWithLoading)
                .previewDisplayName("Loading State")

            ReaktorContainer(viewModel: viewModelWithError)
                .previewDisplayName("Error State")
        }
    }
}
