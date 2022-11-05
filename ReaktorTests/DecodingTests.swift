import Foundation
import XCTest
@testable import Reaktor

class DecodingTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testDecoding() throws {
        // Given
        guard let url = Bundle(for: Self.self).url(forResource: "apiReturn", withExtension: "json") else {
            XCTFail("The URL containing the response was not found")
            return
        }
        let data = try Data(contentsOf: url)

        let decodedData = try CustomDecoder().decode([Graph].self, from: data)
        XCTAssertFalse(decodedData.isEmpty)
    }
}
