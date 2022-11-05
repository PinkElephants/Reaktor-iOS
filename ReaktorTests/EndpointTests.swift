import Foundation
import XCTest

@testable import Reaktor

class EndpointTests: XCTestCase {

    var endpoint: Endpoint!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        self.endpoint = nil
    }

    func testMainAPIURLGeneration() throws {
        // Given
        endpoint = .graphs

        // When
        let url = try endpoint.url

        // Then
        XCTAssertEqual(url.absoluteString, "https://api.npoint.io/graphs?")
    }

    func testInvalidURLGeneration() throws {
        endpoint = .init(path: " /whitespace")

        XCTAssertThrowsError(try endpoint.url)
    }
}
