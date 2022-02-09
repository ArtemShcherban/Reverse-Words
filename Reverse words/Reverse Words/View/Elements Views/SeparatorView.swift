//
//  SeparatorView.swift
//  Reverse words
//
//  Created by Artem Shcherban on 16.01.2022.
//

import UIKit

final class SeparatorView: UIView {
    private let activeColor = ColorsConstants.blueColor
    private let inactiveColor = UIColor.black.withAlphaComponent(0.2)
    
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
        backgroundColor = isActive ? activeColor : inactiveColor
    }
    
    private func configure() {
        NSLayoutConstraint.activate([heightAnchor.constraint(equalToConstant: 1)])
        update()
    }
}
