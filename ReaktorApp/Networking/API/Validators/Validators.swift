import Foundation

protocol HTTPResponseValidator {
    func validate(_ input: HTTPURLResponse) throws
}

/// Validates the status code. Hardcoded values, but could be easily extended with a iniialized defining the boundaries
struct HTTPStatusCodeValidator: HTTPResponseValidator {
    typealias Input = HTTPURLResponse

    func validate(_ input: HTTPURLResponse) throws {
        guard (200..<300).contains(input.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}

/// Validates the content type of a response. Again this can be changed to validate the header fields, or target another header
struct HTTPContentTypeValidator: HTTPResponseValidator {
    typealias Input = HTTPURLResponse

    func validate(_ input: Input) throws {
        guard let contentType = input.allHeaderFields["Content-Type"] as? String,
              contentType.contains("application/json") else {
            throw URLError(.badServerResponse)
        }
    }
}

