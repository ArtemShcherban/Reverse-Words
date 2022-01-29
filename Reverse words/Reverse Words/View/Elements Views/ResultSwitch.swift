//
//  ResultSwitch.swift
//  Reverse words
//
//  Created by Artem Shcherban on 25.01.2022.
//

import UIKit

class ResultSwitch: UISwitch {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        onTintColor = ColorsConstants.blueColor 
    }
}
