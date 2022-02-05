//
//  ReverseWorldModel.swift
//  Reverse words
//
//  Created by Artem Shcherban on 16.12.2021.
//

import Foundation

final class ReverseWordsModel {
    
    private lazy var bufferWord = ""
    private lazy var characterIndex = 0
    private lazy var excludedCharacters: [Int: String] = [:]
    private lazy var arrayOfReversedWords: [String] = []
    private lazy var wordIndex = 0
    private static let alphabetLetters = "abcdefghijklmnopqrstuvwxyz"
    lazy var customExceptions = ""
    
    func reverseWordsWithNoRules(_ string: String) -> String {
        string.split(separator: " ")
            .map({ "\($0)" })
            .map({ String($0.reversed()) })
            .joined(separator: " ")
    }
    
    func reverseWordsWithRule(_ string: String, _ choice: Int) -> String {
        
        let arrayOfInputedWords = string.split(separator: " ")
        arrayOfReversedWords = []
        wordIndex = 0
        
        while wordIndex <= arrayOfInputedWords.count - 1 {
            bufferWord = ""
            excludedCharacters = [:]
            singleWordProcessing(arrayOfInputedWords[wordIndex], choice: choice)
            
        }
        return arrayOfReversedWords.joined(separator: " ")
    }
    
    private func singleWordProcessing(_ word: String.SubSequence, choice: Int) {
        characterIndex = 0
        for character in word {
            if choice == 0 {
                alphabetMappingRule(for: character)
                
            } else if choice == 2 {
                customMappingRule(for: character)
                
            }
            characterIndex += 1
        }
        if !bufferWord.isEmpty {
            let reversedWord = String(bufferWord.reversed())
            arrayOfReversedWords.append(addingExcludedCharacters(to: reversedWord))
            
        } else {
            arrayOfReversedWords.append(addingExcludedCharacters(to: ""))
        }
        wordIndex += 1
    }
    
    private func alphabetMappingRule(for character: Character) {
        if Self.alphabetLetters.contains(character.lowercased()) {
            bufferWord.append(character)
        } else {
            excludedCharacters[characterIndex] = String(character)
        }
    }
    
    private func customMappingRule(for character: Character) {
        if customExceptions.lowercased().contains(character.lowercased()) {
            excludedCharacters[characterIndex] = String(character)
        } else {
            bufferWord.append(character)
        }
    }
    
    private  func addingExcludedCharacters(to reverseword: String) -> String {
        var reversedWord = reverseword
        for character in excludedCharacters.sorted(by: { $0.0 < $1.0 }) {
            reversedWord.insert(contentsOf: character.value,
                                at: reversedWord.index(reversedWord.startIndex, offsetBy: character.key))
        }
        return reversedWord
    }
}
