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
    private lazy var alphabet = "abcdefghijklmnopqrstuvwxyz"
    lazy var customExceptions = ""
    
    func reverseWordsWithNoRules(_ string: String) -> String {
        string.split(separator: " ")
            .map({ "\($0)" })
            .map({ String($0.reversed()) })
            .joined(separator: " ")
    }
    
    func reverseWordsWithRule(_ string: String, _ choice: Int) -> String {
        
        let arrayOfInputedWords = string.split(separator: " ")
        var arrayOfReversedWords: [String] = []
        
        var wordIndex = 0
        
        while wordIndex <= arrayOfInputedWords.count - 1 {
            bufferWord = ""
            excludedCharacters = [:]
            characterIndex = 0
            
            for character in arrayOfInputedWords[wordIndex] {
                if choice == 0 {
                    alphabetRuleMappingOf(character: character)
                    characterIndex += 1
                    
                } else if choice == 2 {
                    customRuleMappingOf(character: character)
                    characterIndex += 1
                }
            }
            
            if bufferWord.isEmpty == false {
                let reversedWord = String(bufferWord.reversed())
                arrayOfReversedWords.append(addExcludedCharactersTo(reversedWord))
                
            } else {
                arrayOfReversedWords.append(addExcludedCharactersTo(""))
            }
            wordIndex += 1
        }
        return arrayOfReversedWords.joined(separator: " ")
    }
    
    private  func alphabetRuleMappingOf(character: Character) {
        if alphabet.contains(character.lowercased()) {
            bufferWord.append(character)
        } else {
            excludedCharacters[characterIndex] = String(character)
        }
    }
    
    private  func customRuleMappingOf(character: Character) {
        if customExceptions.lowercased().contains(character.lowercased()) {
            excludedCharacters[characterIndex] = String(character)
        } else {
            bufferWord.append(character)
        }
    }
    
    private  func addExcludedCharactersTo(_ reverseword: String) -> String {
        var reversedWord = reverseword
        for character in excludedCharacters.sorted(by: { $0.0 < $1.0 }) {
            reversedWord.insert(contentsOf: character.value,
                                at: reversedWord.index(reversedWord.startIndex, offsetBy: character.key))
        }
        return reversedWord
    }
}
