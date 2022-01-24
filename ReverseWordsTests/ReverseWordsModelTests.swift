//
//  ReverseWordsTests.swift
//  ReverseWordsTests
//
//  Created by Artem Shcherban on 07.01.2022.
//

import XCTest
@testable import Reverse_words

class ReverseWordsModelTests: XCTestCase {
   
    private  var modelUnderTest: ReverseWordsModel!
    
    override func setUpWithError() throws {
        
        try super.setUpWithError()
        modelUnderTest = ReverseWordsModel()
    }
    
    override func tearDownWithError() throws {
        
        modelUnderTest = nil
        try super.tearDownWithError()
    }
    
    func testAreTheStringsTheSame() {
        
        let inputString = "I love programming"
        let expectedString = "I evol gnimmargorp"
        
        let reversedString =  modelUnderTest.reverseWordsWithNoRules(inputString)
        
        XCTAssertEqual(reversedString, expectedString, "Strings should be the same")
    }
    
    func testAreTheStringsTheSameWithAlphabetRule() {
        
        let segmentControlIndex = 0
        
        XCTAssertEqual(modelUnderTest.reverseWordsWithRule("Foxminded cool 24/7", segmentControlIndex),
                       "dednimxoF looc 24/7")
        XCTAssertEqual(modelUnderTest.reverseWordsWithRule("abcd efgh", segmentControlIndex), "dcba hgfe")
        XCTAssertEqual(modelUnderTest.reverseWordsWithRule("a1bcd efg!h", segmentControlIndex), "d1cba hgf!e")
        XCTAssertEqual(modelUnderTest.reverseWordsWithRule("Q$W§E(RT¿Y8", segmentControlIndex), "Y$T§R(EW¿Q8")
    }
    
    func testAreTheStringsTheSameWithCustomRule() {
        modelUnderTest.customExceptions = "xl¿W$"
        let segmentControlIndex = 2
        
        XCTAssertEqual(modelUnderTest.reverseWordsWithRule("Foxminded cool 24/7", segmentControlIndex),
                       "dexdnimoF oocl 7/42")
        XCTAssertEqual(modelUnderTest.reverseWordsWithRule("abcd efgh", segmentControlIndex), "dcba hgfe")
        XCTAssertEqual(modelUnderTest.reverseWordsWithRule("a1bcd efglh", segmentControlIndex), "dcb1a hgfle")
        XCTAssertEqual(modelUnderTest.reverseWordsWithRule("Q$W§E(RT¿Y8", segmentControlIndex), "8$WYTR(E¿§Q")
    }
}
