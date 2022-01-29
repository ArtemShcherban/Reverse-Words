//
//  ReverseWordsTextField.swift
//  Reverse words
//
//  Created by Artem Shcherban on 23.01.2022.
//

import UIKit

final class ReverseWordsTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
     
   private func configure() {
        backgroundColor = .white
        textColor = ColorsConstants.greyColor
        font = UIFont(name: FontConstants.FontName.sfUIDisplayRegular,
                                                 size: FontConstants.Size.regular)
        
        clearButtonMode = .whileEditing
    }
}
