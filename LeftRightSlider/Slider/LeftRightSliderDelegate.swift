//
//  LeftRightSliderDelegate.swift
//  LeftRightSlider
//
//  Created by TienLe on 10/25/17.
//  Copyright © 2017 TL. All rights reserved.
//

import Foundation
import UIKit

protocol LeftRightSliderDelegate : class {
    func tlSlider(_slider : UISlider, changeToValue: Float) -> Void
    func tlSlider(_slider : UISlider, didEndSliding: Float) -> Void
}
