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
        
        let reversedString =  modelUnderTest.reverseWords(inputString)
        
        XCTAssertEqual(reversedString, expectedString, "Strings should be the same")
    }
}
