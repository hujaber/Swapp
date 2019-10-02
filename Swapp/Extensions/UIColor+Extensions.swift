//
//  UIColor+Extensions.swift
//  Swapp
//
//  Created by Hussein Jaber on 30/9/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func colorWithRGBA(_ r: Int, _ g: Int, _ b: Int, _ a: CGFloat = 1) -> UIColor {
        .init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: a)
    }
    
    static let appBackgroundColor: UIColor = {
        if #available(iOS 13, *) {
            return .systemBackground
        } else {
            return .white
        }
    }()
    
    static let appThemeColor: UIColor = {
        if #available(iOS 13, *) {
            return .systemTeal
        } else {
            return UIColor.init(red: 28.0/255.0, green: 171.0/255.0, blue: 226.0/255.0, alpha: 1.0)
        }
    }()
    
    static let categoryCellShadowColor: UIColor = {
        if #available(iOS 13, *) {
            return .systemGray2
        } else {
            return .init(red: 173.0/255.0,
                         green: 183.0/255.0,
                         blue: 197.0/255.0,
                         alpha: 1.0)
        }
    }()
}
