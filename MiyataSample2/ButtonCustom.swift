//
//  File.swift
//  MiyataSample2
//
//  Created by 宮田恵里 on 2017/10/25.
//  Copyright © 2017年 宮田恵里. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class Button_Custom: UIButton {
    
    @IBInspectable var textColor: UIColor?
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
//    @IBInspectable var borderColor: UIColor = UIColor.clear {
//        didSet {
//            layer.borderColor = borderColor.cgColor
//        }
//    }
}
