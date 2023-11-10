
import XCTest

final class KalculatorTests: XCTestCase {

	var calculator: Calculator!
	var viewController: ViewController!
   

    override func setUpWithError() throws 
{
   super.setUp()
   calculator = Calculator()
 
   let storyboard = UIStoryboard(name: "Main", bundle: nil)
   viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
   _ = viewController.view
}

    override func tearDownWithError() throws 
{
        calculator = nil
        super.tearDown()
    }



 func testInputDigitPositive()
 {
        let result = try? calculator.inputDigit("9")
        XCTAssertEqual(result, "9")
    }



func testInputInvalidDigit()
{
       let invalidDigitButton = UIButton()
        invalidDigitButton.setTitle("Hello", for: .normal)
         viewController.inputDigit(invalidDigitButton)
         XCTAssertEqual(viewController.resultScreen.text, "invalid")
    }
    
    
    func testInputDigit() 
{
        let digitButton = UIButton()
        digitButton.setTitle("99", for: .normal)
         viewController.inputDigit(digitButton)
        
        XCTAssertEqual(viewController.resultScreen.text, "99")
    }
    
    func testClearOfViewController() 
{
        viewController.resultScreen.text = "3"
        viewController.clear(UIButton())
        XCTAssertEqual(viewController.resultScreen.text, "0")
}

    
    
    
 
  func testClearPostive() 
{
        try? calculator.inputDigit("9")
        calculator.clear()
        XCTAssertEqual(try? calculator.inputDigit("="), "0")
    }

    func testClearNegative() 
{
        calculator.clear()
        XCTAssertNotEqual(try? calculator.inputDigit("="), "")
  }

 
 
    
    
    
    func testInputDigitNegative() 
{
        XCTAssertThrowsError(try calculator.inputDigit("5a")) { error in
            XCTAssertEqual(error as? CalculatorError, CalculatorError.invalidDigit)
        }
    }
    
    
    func testAppendPositive()
{
        try? calculator.appendDigit("1")
        try? calculator.appendDigit("2")        
        XCTAssertEqual(try? calculator.inputDigit("="), "12")
    }
    
    func testAppendNegative() 
{
        try? calculator.appendDigit("54")
        XCTAssertThrowsError(try calculator.inputDigit("A54")) 
{ error in
            XCTAssertEqual(error as? CalculatorError, CalculatorError.invalidDigit)
        }
    }

    

func testAddPositive() 
{
        try? calculator.inputDigit("70")
        try? calculator.performOperation(.add)
        try? calculator.inputDigit("10")
        try? calculator.performOperation(.equals)
        XCTAssertEqual(try? calculator.inputDigit("="), "80")
    }
    
    func testAddNegative() {
        try? calculator.inputDigit("11")
        try? calculator.performOperation(.add)
        try? calculator.inputDigit("13")
        try? calculator.performOperation(.equals)
        XCTAssertNotEqual(try? calculator.inputDigit("="), "47")
    }
    
    func testSubPositive() {
        try? calculator.inputDigit("2")
        try? calculator.performOperation(.subtract)
        try? calculator.inputDigit("1")
        try? calculator.performOperation(.equals)
        XCTAssertEqual(try? calculator.inputDigit("="), "1")
    }
    
    func testSubNegative() {
        try? calculator.inputDigit("8")
        try? calculator.performOperation(.subtract)
        try? calculator.inputDigit("3")
        try? calculator.performOperation(.equals)
        XCTAssertNotEqual(try? calculator.inputDigit("="), "2")
    }
    
    
func testMultiplicationPositive() 
{
        try? calculator.inputDigit("3")
        try? calculator.performOperation(.multiply)
        try? calculator.inputDigit("9")
        try? calculator.performOperation(.equals)
        XCTAssertEqual(try? calculator.inputDigit("="), "27")
    }
    
    func testMultiplicationNegative() 
{
        try? calculator.inputDigit("7")
        try? calculator.performOperation(.multiply)
        try? calculator.inputDigit("7")
        try? calculator.performOperation(.equals)
        XCTAssertNotEqual(try? calculator.inputDigit("="), "8")
    }
    
    func testDivisionPositive() 
{
        try? calculator.inputDigit("4")
        try? calculator.performOperation(.divide)
        try? calculator.inputDigit("2")
        try? calculator.performOperation(.equals)
        XCTAssertEqual(try? calculator.inputDigit("="), "2")
    }
    
    func testDivisionNegative() 
{
        try? calculator.inputDigit("99")
        try? calculator.performOperation(.divide)
        try? calculator.inputDigit("11")
        try? calculator.performOperation(.equals)
        XCTAssertNotEqual(try? calculator.inputDigit("="), "23")
    }
    
    
    func testDivisionByZero() {
        try? calculator.inputDigit("9")
        try? calculator.performOperation(.divide)
        try? calculator.inputDigit("0")
        XCTAssertThrowsError(try calculator.performOperation(.equals)) { error in
            XCTAssertEqual(error as? CalculatorError, CalculatorError.illegalOperation)
        }
    }
        
    


}
