//
//  RulesSegmentControl.swift
//  Reverse words
//
//  Created by Artem Shcherban on 22.01.2022.
//

import UIKit

final class RulesSegmentControl: UISegmentedControl {
    
    private let activeColr = ColorsConstants.blueColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        insertSegment(withTitle: "alphabet", at: 0, animated: true)
        insertSegment(withTitle: "no rules", at: 1, animated: true)
        insertSegment(withTitle: "custom", at: 2, animated: true)
        selectedSegmentIndex = 1
        selectedSegmentTintColor = ColorsConstants.blueColor
        setTitleTextAttributes([NSAttributedString.Key.font:
                                    UIFont(name: FontConstants.FontName.sfUIDisplayRegular, size: 17) as Any], for: .normal)
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor:
                                    UIColor.white ], for: .selected)
        NSLayoutConstraint.activate([self.heightAnchor.constraint(equalToConstant: 31)])
    }
    
}
