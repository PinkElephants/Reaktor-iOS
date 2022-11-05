import Foundation
import SwiftUI

struct ErrorPage: View {
    let errorReason: String
    let retryAction: (() -> Void)?

    var body: some View {
        VStack {
            Text(errorReason)
                .bold()
                .italic()
                .foregroundColor(.secondary)
                .accessibilityIdentifier("ErrorReasonText")
                .padding()

            Button("Retry") {
                retryAction?()
            }
            .accessibilityIdentifier("RetryButton")
        }
    }
}
