//
//  ReverseButton.swift
//  Reverse words
//
//  Created by Artem Shcherban on 16.01.2022.
//

import UIKit

final class ReverseButton: UIButton {
    
    private let activeColor = ColorsConstants.blueColor
    private let inactiveColor = ColorsConstants.blueColor.withAlphaComponent(0.6)
    
    var isActive = false {
        didSet {
            guard oldValue != isActive else { return }
            update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func update() {
        if isActive {
            backgroundColor = activeColor
            isEnabled = isActive
        } else {
            backgroundColor = inactiveColor
            isEnabled = isActive
        }
    }
    
    private func configure() {
        setTitle("Reverse", for: .normal)
        setTitle("Clear", for: .selected)
        titleLabel?.font = UIFont(name: FontConstants.FontName.sfUIDisplayRegular, size: FontConstants.Size.regular)
        layer.cornerRadius = 14
        isEnabled = isActive
        NSLayoutConstraint.activate([self.heightAnchor.constraint(equalToConstant: 56)])
        update()
    }
}
