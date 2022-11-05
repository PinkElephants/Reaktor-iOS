import Foundation

// Conversational way to build TimeIntervals.

extension TimeInterval {
    var days: TimeInterval {
        self.hours * 24
    }

    var hours: TimeInterval {
        self.minutes * 60
    }

    var minutes: TimeInterval {
        self * 60
    }
}

class CustomDecoder: JSONDecoder {
    override init() {
        super.init()
        dateDecodingStrategy = .iso8601
    }
}
