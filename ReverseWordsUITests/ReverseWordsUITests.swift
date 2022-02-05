//
//  ReverseWordsUITests.swift
//  ReverseWordsUITests
//
//  Created by Artem Shcherban on 08.01.2022.
//

import XCTest

class ReverseWordsUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    private lazy var resultSwitch = app.switches["ResultSwitch"]
    private lazy var textToReverse = app.textFields["TextToReverse"]
    private lazy var reverseTextLabel = app.staticTexts["ReverseTextLabel"]
    private lazy var segmentControl = app.segmentedControls["RulesSegmentControl"]
    private lazy var textToIgnore = app.textFields["TextToIgnore"]
    private lazy var reverseButton = app.buttons["ReverseButton"]
    private lazy var mainView = app.otherElements["ReverseWordsView"]
    private lazy var returnButton = app.buttons["Return"]
    
    override func setUpWithError() throws {
        
        try super.setUpWithError()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    func typeInReverseText(_ text: String) {
        textToReverse.tap()
        textToReverse.typeText(text)
    }
    
    func testReverseButtonDisplayReversedTextOnTap() {
        //       given
        let inputString = "Super Retina XDR display \n"
        let expectedString = "repuS aniteR RDX yalpsid"
        
        //       when
        typeInReverseText(inputString)
        reverseButton.tap()
        
        //       then
        XCTAssertEqual(reverseTextLabel.label, expectedString, "Strings should be the same")
    }
    
    func testTextFieldAndReversedStringClearsOnReverseButtonSecondTap() {
        //       given
        let inputString = "Super Retina XDR display \n"
        let expectedString = ""
        
        //       when
        typeInReverseText(inputString)
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
        typeInReverseText(inputString)
        reverseButton.tap()
        typeInReverseText(additionalInputString)
        
        //       then
        XCTAssertFalse(reverseTextLabel.exists)
    }
    
    func testReverseButtonStateAfterEnteringText() {
        //       given
        let inputString = "Super Retina XDR display"
        let expectedButtonTitle = "Reverse"
        
        //       when
        typeInReverseText(inputString)
        returnButton.tap()
        
        //       then
        XCTAssertFalse(reverseButton.isSelected)
        XCTAssertTrue(reverseButton.isEnabled)
        XCTAssertEqual(reverseButton.label, expectedButtonTitle, "Button title should be 'Reverse'")
    }
    
    func testTextToIgnoreAppearOnSegmentChange() {
        segmentControl.buttons.element(boundBy: 2).tap()
        XCTAssertTrue(textToIgnore.exists)
    }
    
    func testResultCheckWithAlphabetRule() {
        //       given
        let inputString = "Q$W§E(RT¿Y8"
        let expectedString = "Y$T§R(EW¿Q8"
        
        //       when
        typeInReverseText(inputString)
        segmentControl.buttons.element(boundBy: 0).tap()
        reverseButton.tap()
        
        //       then
        XCTAssertEqual(reverseTextLabel.label, expectedString, "Strings should be the same")
    }
    
    func testResultCheckWithCustomRule() {
        //       given
        let inputString = "Q$W§E(RT¿Y8"
        let customExceptions = "¿W$"
        let expectedString = "8$WYTR(E¿§Q"
        
        //       when
        segmentControl.buttons.element(boundBy: 2).tap()
        textToIgnore.tap()
        textToIgnore.typeText(customExceptions)
        typeInReverseText(inputString)
        returnButton.tap()
        reverseButton.tap()
        
        //       then
        XCTAssertEqual(reverseTextLabel.label, expectedString, "Strings should be the same")
    }
    
    func testResultCheckAfterSegmentIndexChangedkWithAlphabetRule() {
        //       given
        let inputString = "Q$W§E(RT¿Y8"
        let expectedString = "Y$T§R(EW¿Q8"
        
        //       when
        typeInReverseText(inputString)
        returnButton.tap()
        reverseButton.tap()
        segmentControl.buttons.element(boundBy: 0).tap()
        
        //       then
        XCTAssertEqual(reverseTextLabel.label, expectedString, "Strings should be the same")
    }
    
    func testResultCheckAfeterSetCustomRule() {
        //       given
        let inputString = "Q$W§E(RT¿Y8"
        let customExceptions = "¿W$"
        let expectedString = "8$WYTR(E¿§Q"
        
        //       when
        typeInReverseText(inputString)
        returnButton.tap()
        reverseButton.tap()
        segmentControl.buttons.element(boundBy: 2).tap()
        textToIgnore.tap()
        textToIgnore.typeText(customExceptions)
        returnButton.tap()
        reverseButton.tap()
        
        //       then
        XCTAssertEqual(reverseTextLabel.label, expectedString, "Strings should be the same")
    }
    
    func testReverseButtonStateWithEnteredStringAndSwitchControlOff() {
        //       given
        let inputString = "Q$W§E(RT¿Y8"
        
        //       when
        resultSwitch.tap()
        typeInReverseText(inputString)
        resultSwitch.tap()
        
        //       then
        
        XCTAssertTrue(reverseButton.isSelected)

    }
}
