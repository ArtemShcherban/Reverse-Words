//
//  FontSizeConstant.swift
//  Reverse words
//
//  Created by Artem Shcherban on 04.01.2022.
//

import UIKit

struct FontConstants {
    
    struct FontName {
        static let sfUIDisplayRegular = "SFUIDisplay-Regular"
        static let sfUIDisplayBold = "SFUIDisplay-Bold"
        static let sfUIDisplaySemibold = "SFUIDisplay-Semibold"
    }
    
    struct Size {
        
        static let title: CGFloat = 34
        static let subTitle: CGFloat = 24
        static let regular: CGFloat = 17
    }
    
    struct Kern {
        static let regular = -0.41
    }
}
