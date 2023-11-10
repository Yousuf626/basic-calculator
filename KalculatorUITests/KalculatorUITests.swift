

import XCTest

final class CalculatorUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()

        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    
    func testExistenceOfCalculatorButtons() {
        let buttonIdentifiers = ["7", "9", "2", "5", "4", "1", "6", "8", "3", "0", "+", "-", "*", "/", "=", "C"]
        for identifier in buttonIdentifiers {
            XCTAssertTrue(app.buttons[identifier].exists, "The \(identifier) button should exist.")
        }
    }
    
   
    func testFunctionalityOfResultDisplay() {
        tapButtons(["1", "1"])
        XCTAssertEqual(resultLabelText(), "11")
        
        tapButtons(["-", "1", "0"])
        XCTAssertEqual(resultLabelText(), "1")
        
        tapButtons(["="])
        XCTAssertEqual(resultLabelText(), "1")
        
        tapButtons(["C"])
        XCTAssertEqual(resultLabelText(), "0")
    }
    
   
    func testCalculatorComputationAccuracy() {
        tapButtons(["8", "1", "/", "9", "="])
        XCTAssertEqual(resultLabelText(), "9")
        
        tapButtons(["*", "1", "0", "="])
        XCTAssertEqual(resultLabelText(), "90")
    }
    
   
    func testCalculatorErrorHandling() {
        tapButtons(["11", "/", "0", "="])
        XCTAssertEqual(resultLabelText(), "Err")
        
        tapButtons(["C"])
        XCTAssertEqual(resultLabelText(), "0")
    }
    
    private func tapButtons(_ buttonLabels: [String]) {
        buttonLabels.forEach { app.buttons[$0].tap() }
    }
    
    private func resultLabelText() -> String {
        return app.staticTexts.element(matching: .any, identifier: "resultScreen").label
    }
}
