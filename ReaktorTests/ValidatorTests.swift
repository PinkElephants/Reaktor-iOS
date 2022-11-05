//
//  ValidatorTests.swift
//  ReaktorTests
//
//  Created by Kirill Ivonin on 04/11/22.
//

import Foundation
import XCTest
@testable import Reaktor

class ValidatorTests: XCTestCase {

    // MARK: - Response Code
    func testHTTPCodeValidatorValid() {
        let sut = HTTPStatusCodeValidator()
        let response = HTTPURLResponse(url: URL(string: "localhost")!, statusCode: 200, httpVersion: nil, headerFields: nil)!

        XCTAssertNoThrow(try sut.validate(response))
    }

    func testHTTPCodeValidatorInvalid() {
        let sut = HTTPStatusCodeValidator()
        let response = HTTPURLResponse(url: URL(string: "localhost")!, statusCode: 400, httpVersion: nil, headerFields: nil)!

        XCTAssertThrowsError(try sut.validate(response))
    }

    // MARK: - Content Type
    func testHTTPContentTypeValidatorInvalid() {
        let sut = HTTPContentTypeValidator()
        let response = HTTPURLResponse(url: URL(string: "localhost")!, statusCode: 200, httpVersion: nil, headerFields: [:])!

        XCTAssertThrowsError(try sut.validate(response))
    }

    func testHTTPContentTypeValidatorValid() {
        let sut = HTTPContentTypeValidator()
        let response = HTTPURLResponse(
            url: URL(string: "localhost")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: ["Content-Type": "application/json"]
        )!

        XCTAssertNoThrow(try sut.validate(response))
    }

}
