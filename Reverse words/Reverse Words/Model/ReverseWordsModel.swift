//
//  ReverseWorldModel.swift
//  Reverse words
//
//  Created by Artem Shcherban on 16.12.2021.
//

import Foundation

final class ReverseWordsModel {
    
    func reverseWords(_ string: String) -> String {
        string.split(separator: " ")
            .map({ "\($0)" })
            .map({ String($0.reversed()) })
            .joined(separator: " ")
    }
}
