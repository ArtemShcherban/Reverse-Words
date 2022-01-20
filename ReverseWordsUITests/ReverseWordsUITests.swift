//
//  ReverseWordsUITests.swift
//  ReverseWordsUITests
//
//  Created by Artem Shcherban on 08.01.2022.
//

import XCTest

class ReverseWordsUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    private lazy var textToReverse = app.textFields["TextToReverse"]
    private lazy var reverseTextLabel = app.staticTexts["ReverseTextLabel"]
    private lazy var reverseButton = app.buttons["ReverseButton"]
    private lazy var mainView = app.otherElements["ReverseWordsView"]
    private lazy var returnButton = app.buttons["Return"]
    
    override func setUpWithError() throws {
        
        try super.setUpWithError()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    func testReverseButtonDisplayReversedTextOnTap() {
        //       given
        let inputString = "Super Retina XDR display \n"
        let expectedString = "repuS aniteR RDX yalpsid"
        
        //       when
        textToReverse.tap()
        textToReverse.typeText(inputString)
        reverseButton.tap()
        
        //       then
        XCTAssertEqual(reverseTextLabel.label, expectedString, "Strings should be the same")
    }
    
    func testTextFieldAndReversedStringClearsOnReverseButtonSecondTap() {
        //       given
        let inputString = "Super Retina XDR display \n"
        let expectedString = ""
        
        //       when
        textToReverse.tap()
        textToReverse.typeText(inputString)
        reverseButton.tap()
        reverseButton.tap()
        
        //       then
        XCTAssertFalse(reverseTextLabel.exists)
        XCTAssertEqual(textToReverse.label, expectedString, "textField should be clear")
    }
    
    func testReversedStringClearsAfterEditingTextField() {
        //       given
        let inputString = "Super Retina \n"
        let additionalInputString = " XDR display \n"
        
        //       when
        textToReverse.tap()
        textToReverse.typeText(inputString)
        reverseButton.tap()
        textToReverse.tap()
        textToReverse.typeText(additionalInputString)
        
        //       then
        XCTAssertFalse(reverseTextLabel.exists)
    }
    
    func testReverseButtonStateAfterEnteringText() {
        //       given
        let inputString = "Super Retina XDR display"
        let expectedButtonTitle = "Reverse"
        
        //        when
        textToReverse.tap()
        textToReverse.typeText(inputString)
        returnButton.tap()
        
        //        then
        XCTAssertFalse(reverseButton.isSelected)
        XCTAssertTrue(reverseButton.isEnabled)
        XCTAssertEqual(reverseButton.label, expectedButtonTitle, "Button title should be 'Reverse'")
    }
    
    func testReverseButtonPressedFirstTime() {
        //       given
        textToReverse.tap()
        textToReverse.typeText("Super Retina XDR display \n")
        
        //        when
        reverseButton.tap()
        
        //        then
        XCTAssertTrue(reverseButton.isSelected)
        XCTAssertEqual(reverseButton.label, "Clear", "Button title should be 'Clear'")
        XCTAssertTrue(reverseButton.isEnabled)
    }
    
    func testReverseButtonPressedSecondTime() {
        //       given
        textToReverse.tap()
        textToReverse.typeText("Super Retina XDR display \n")
        reverseButton.tap()
        
        //        when
        reverseButton.tap()
        
        //        then
        XCTAssertFalse(reverseButton.isSelected)
        XCTAssertEqual(reverseButton.label, "Reverse", "Button title should be 'Reverse'")
        XCTAssertFalse(reverseButton.isEnabled)
    }
}
