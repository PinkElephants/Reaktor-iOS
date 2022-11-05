//
//  APITests.swift
//  ReaktorTests
//
//  Created by Kirill Ivonin on 04/11/22.
//

import Foundation
import XCTest
@testable import Reaktor

class APITests: XCTestCase {

    var sut: MoodsApi!

    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]

        self.sut = MoodsApi(configuration: configuration)
    }

    private func makeResponse(
        _ request: URLRequest,
        statusCode: Int,
        headerFields: [String: String] = [:],
        data: Data
    ) -> (HTTPURLResponse, Data) {

        let response = HTTPURLResponse(
            url: request.url!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: headerFields)!

        return (response, data )
    }

    func testLoaderSuccess() async throws {
        // Given
        let request = ReaktorListRequest()
        let data = Bundle.jsonData(for: "apiReturn")

        MockURLProtocol.requestHandler =  { [weak self] request in
            guard let self = self else {
                XCTFail()
                fatalError()
            }
            return self.makeResponse(request, statusCode: 200, headerFields: ["Content-Type": "application/json"], data: data)
        }

        // When
        let responseData = try await sut.request(request)

        // Then
        XCTAssertEqual(responseData.count, 1)
    }

    func testLoaderThrowsAtMissingHeaders() async {
        // Given
        let request = ReaktorListRequest()
        let data = Bundle.jsonData(for: "apiReturn")
        MockURLProtocol.requestHandler =  { [weak self] request in
            guard let self = self else {
                XCTFail()
                fatalError()
            }
            return self.makeResponse(request, statusCode: 200, data: data)
        }

        do {
            // When
            _ = try await sut.request(request)
            XCTFail("Expected failure")
        } catch {
            // Then
            XCTAssertNotNil(error)
        }
    }

    func testLoaderThrowsAtInvalidHTTPCode() async {
        // Given
        let request = ReaktorListRequest()
        let data = Bundle.jsonData(for: "apiReturn")

        MockURLProtocol.requestHandler =  { [weak self] request in
            guard let self = self else {
                XCTFail()
                fatalError()
            }
            return self.makeResponse(request, statusCode: 302, headerFields: ["Content-Type": "application/json"], data: data)
        }

        do {
            // When
            _ = try await sut.request(request)
            XCTFail("Expected failure")
        } catch {
            // Then
            XCTAssertNotNil(error)
        }
    }

    func testLoaderFailure() async {
        // Given
        let request = ReaktorListRequest()

        MockURLProtocol.requestHandler =  { request in
            throw URLError(.badURL)
        }

        // When
        do {
            _ = try await sut.request(request)
            XCTFail("Expected failure")
        } catch { }
    }
}
