import Foundation
@testable import Reaktor

class MockedAPIImplementation: API {
    var error: Error?

    var mockedDataFile: String

    init(mockedDataFile: String) {
        self.mockedDataFile = mockedDataFile
    }

    func request<T>(_ endpoint: T, method: HTTPMethod, responseValidators: [HTTPResponseValidator] = []) async throws -> T.ResponseType where T : RequestMaker, T : ResponseParser {

        if let error = error {
            throw error
        }

        let data = Bundle.jsonData(for: mockedDataFile)
        return try endpoint.parse(data)
    }
}

enum ErrorMock: Error, LocalizedError {
    case generic

    var errorDescription: String? {
        "GenericError"
    }
}
