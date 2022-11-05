//
//  ReaktorListRequestTests.swift
//  ReaktorTests
//
//  Created by Kirill Ivonin on 04/11/22.
//

import Foundation
import XCTest

@testable import Reaktor

class ReaktorListRequestTests: XCTestCase {

    var sut: ReaktorListRequest!

    override func setUp() {
        super.setUp()

        self.sut = .init()
    }

    func testMakeURLRequest() throws {
        // When
        let request = try sut.makeRequest()

        // Then
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url?.absoluteString, "https://api.npoint.io/graphs?")
    }

    func testParseResponse() throws {
        // Given
        let data = Bundle.jsonData(for: "apiReturn")

        // When
        let response = try sut.parse(data)

        // Then
        let firstElement = response.first!
        let expectedText = "Nisi sint proident adipisicing consectetur duis pariatur dolore ipsum est. Sit deserunt elit occaecat anim voluptate nulla anim occaecat occaecat sit tempor eu non. Veniam dolore elit culpa sit aute cupidatat dolor nostrud occaecat adipisicing nostrud. Sint dolor ex aute tempor esse mollit cupidatat pariatur ullamco ad nulla officia veniam.\r\n"

        XCTAssertEqual(response.count, 1)
        XCTAssertEqual(firstElement.text, expectedText)
    }
}
