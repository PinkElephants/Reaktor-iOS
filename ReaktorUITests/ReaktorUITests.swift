import XCTest

class ReaktorUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    // At the moment is using the real API, but the ideal scenario would use a local-mock server
    // (WireMock?) to proxy the responses by consistently returning the expected json response.
    func testDisplayedData() throws {
        let app = XCUIApplication()
        app.launch()

        // SearchBar exists
        let searchTextField = app.textFields.firstMatch
        XCTAssertTrue(searchTextField.exists)

        // Cells are displayed
        waitForExistence(app.cells.element(boundBy: 1), 10)

        // Row contains the correct items
        // First cell is header (search bar)
        let headerCell = app.cells.element(boundBy: 1)
        XCTAssertEqual(headerCell.textFields.count, 0)

        // Second item contains text
        let firstRow = app.cells.element(boundBy: 1)
        XCTAssertTrue(firstRow.staticTexts["factText"].exists)
        XCTAssertFalse(firstRow.images["checkmarkIcon"].exists)
        XCTAssertFalse(firstRow.images["newIcon"].exists)

        // Third item is verified
        let secondRow = app.cells.element(boundBy: 2)
        XCTAssertEqual(secondRow.images.count, 1)
        XCTAssertTrue(secondRow.staticTexts["factText"].exists)
        XCTAssertTrue(secondRow.images["checkmarkIcon"].exists)
        XCTAssertFalse(secondRow.images["newIcon"].exists)

        // Fourth item is verified and new
        let thirdRow = app.cells.element(boundBy: 3)
        XCTAssertEqual(thirdRow.images.count, 2)
        XCTAssertTrue(thirdRow.staticTexts["factText"].exists)
        XCTAssertTrue(thirdRow.images["checkmarkIcon"].exists)
        XCTAssertTrue(thirdRow.images["newIcon"].exists)
    }

}

extension XCTestCase {
    func waitForExistence(_ element: XCUIElement, _ timeout: TimeInterval) {
        let startTime = Date()

        while !element.exists {
            let isExpired = Date().distance(to: startTime) > timeout
            if isExpired {
                XCTFail("The element did not exist in the time constraint")
            }
        }
    }
}
