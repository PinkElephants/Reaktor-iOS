import Foundation

func isRunningOnPreviews() -> Bool {
    guard let value = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] else {
        return false
    }

    return value == "1"
}

