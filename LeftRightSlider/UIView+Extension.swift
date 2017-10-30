//
//  UIView+Extension.swift
//  LeftRightSlider
//
//  Created by TienLe on 10/17/17.
//  Copyright © 2017 TL. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
//    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
//        return CGRect(x: x, y: y, width: width, height: height)
//    }
//    
//    func CGPointMake(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
//        return CGPoint(x: x, y: y)
//    }
    
    func makeBorder(sizeCornor: CGFloat, borderWidth: CGFloat, borderColor: UIColor?) -> Void {
        self.layer.cornerRadius = sizeCornor
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }
}
