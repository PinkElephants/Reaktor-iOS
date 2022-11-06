import Foundation
import SwiftUI

/// The container represents the entry point for our interface.
///
/// The viewModel works with a `State`, and the interface becomes a simple switch or function on
/// the `@published state`.
///
struct ReaktorContainer: View {

    @State var spotifyAccess: Bool = false
    @State var tabSelection: Int
    @State var showingPopup = false
    @StateObject var viewModel: ReaktorViewModel = .init()

    init(spotifyAccess: State<Bool>, tabSelection: State<Int>) {
        self._spotifyAccess = spotifyAccess
        self._tabSelection = tabSelection
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                switch viewModel.state {
                case .loading, .completed:
                    LinearGradient.heale.overlay(
                        ScrollView {
                            VStack(alignment: .leading, spacing: 16) {
                                Button {
                                    showingPopup = true
                                } label: {
                                    ScoreHeader()
                                }

                                if spotifyAccess == false {
                                    Button {
                                        tabSelection = 2
                                    } label: {
                                        SpotifyWarning()
                                    }
                                } else {
                                    BarChart(sadness: viewModel.sadness)
                                }
                                Spacer()
                            }
                            .padding([.leading], 12)
                            .padding([.trailing, .top, .bottom], 32)
                        }.padding([.bottom], 1)
                    )
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                HealeHeader().padding([.top], 64)
                            }
                        }
                    case .error(let reason):
                        ErrorPage(errorReason: reason) {
                            Task {
                                await viewModel.fetchSadness()
                            }
                        }.navigationTitle(Text("Error :("))
                }
            }.popover(isPresented: $showingPopup, content: {
                ScorePopover().ignoresSafeArea()
            })
            .onAppear(perform: viewModel.onAppear)
        }
    }
}

struct ReaktorContainer_Previews: PreviewProvider {

    static var viewModelWithContent: ReaktorViewModel {
        let vm = ReaktorViewModel(sadness: [])
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

        @State var access: Bool = true
        @State var selection: Int = 0

        return Group {
            ReaktorContainer(spotifyAccess: _access, tabSelection: _selection)
                .previewDisplayName("Content State")
        }
    }
}
