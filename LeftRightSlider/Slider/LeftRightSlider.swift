//
//  LeftRightSlider.swift
//  LeftRightSlider
//
//  Created by TienLe on 10/17/17.
//  Copyright © 2017 TL. All rights reserved.
//

import Foundation
import UIKit

class LeftRightSlider: UIView {

    var skyLine : Float = 0.0
    var maximum : Float = 1.0
    var minimum : Float = 0.0
    var current : Float = 0.0;
    var sliderHeight : Float = 6.0;
    var selectedColor : UIColor = UIColor.init(red: 179.0/255.0, green: 179.0/255.0, blue: 193.0/255.0, alpha: 0.8)
    var unSelectedColor : UIColor = UIColor.init(red: 55.0/255.0, green: 55.0/255.0, blue: 94.0/255.0, alpha: 0.8)
    
    private var slider : UISlider?
    private var colorView : LeftRightColor?
    private var currentSliderPoint : CGPoint?
    
    var tlDelegate : LeftRightSliderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    init(frame: CGRect, customSlider: UISlider) {
        super.init(frame: frame)
        slider = customSlider
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() -> Void {
        self.backgroundColor = UIColor.clear
        setupSlider()
        setupColor()
        self.bringSubview(toFront: slider!)
    }
    
    private func setupSlider() -> Void {
        if slider == nil {
            slider = UISlider.init(frame: self.bounds)
            slider?.backgroundColor = UIColor.clear
        }
        
        slider?.setMaximumTrackImage(UIImage.init(), for: .normal)
        slider?.setMinimumTrackImage(UIImage.init(), for: .normal)
        
        slider?.addTarget(self, action: #selector(sliderValuaChange(aSlider:)), for: .valueChanged)
        slider?.addTarget(self, action: #selector(sliderDidEndSliding(aSlider:)), for: .touchUpInside)
        slider?.maximumValue = maximum;
        slider?.minimumValue = minimum;
        slider?.setValue(current, animated: false)
        self.addSubview(slider!)
        
        let views : [String : UISlider] = ["slider" : slider!]
        slider?.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[slider]-0-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[slider]-0-|", options: [], metrics: nil, views: views))
    }
    
    private func setupColor() -> Void {
        if colorView != nil {
            colorView?.removeFromSuperview()
            colorView = nil;
        }
        
        colorView = LeftRightColor.init(frame: self.bounds)
        colorView?.backgroundColor = UIColor.green
        colorView?.trackColor = selectedColor
        colorView?.runingColor = unSelectedColor
        self.addSubview(colorView!)
        
        let views : [String : LeftRightColor] = ["colorView" : colorView!]
        colorView?.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[colorView]-0-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[colorView]-0-|", options: [], metrics: nil, views: views))
        
        setupTrackingSliderColor()
    }
    
    func reloadData() -> Void {
        slider?.maximumValue = maximum
        slider?.minimumValue = minimum
        slider?.setValue(current, animated: false)
        
        colorView?.runingColor = selectedColor
        colorView?.trackColor = unSelectedColor
        
        if sliderHeight == 0 {
            sliderHeight = 6
        }
        
        setupTrackingSliderColor()
        
    }
    
    private func setupTrackingSliderColor() -> Void {
        let trackingRect : CGRect = CGRect(x : minPosition(),
                                           y : CGFloat((colorView?.frame.size.height)!)/2.0,
                                           width : maxPosition() - minPosition(),
                                           height : CGFloat(sliderHeight))
        colorView?.setupTrackView(frame: trackingRect)
        
        let runningRect : CGRect = CGRect(x : defaultSliderPoint().x,
                                          y : CGFloat((colorView?.frame.size.height)!/2.0),
                                          width : CGFloat(sliderHeight),
                                          height : CGFloat(sliderHeight))
        colorView?.setupRunningView(frame: runningRect)
        
        colorView?.layoutSubviews()
        colorView?.drawColor(_from: defaultSliderPoint(), _to: firstSliderPoint())
    }
    
    @objc func sliderValuaChange(aSlider: UISlider) -> Void {
        if let delegate = tlDelegate {
            let trackRect : CGRect = (slider?.trackRect(forBounds: (slider?.bounds)!))!
            let thumbRect : CGRect = (slider?.thumbRect(forBounds: (slider?.bounds)!, trackRect: trackRect, value: (slider?.value)!))!
            
            let point = CGPoint(x: thumbRect.origin.x + thumbRect.size.width/2.0, y: thumbRect.origin.y)
            currentSliderPoint = point
            
            colorView?.drawColor(_from: defaultSliderPoint(), _to: currentSliderPoint!)
            
            delegate.tlSlider(_slider: aSlider, changeToValue: aSlider.value)
        }
    }
    
    @objc func sliderDidEndSliding(aSlider: UISlider) -> Void {
        if let delegate = tlDelegate {
            delegate.tlSlider(_slider: aSlider, didEndSliding: aSlider.value)
        }
    }
    
    private func setSlider(value: Float, animation: Bool) -> Void {
        current = value
        slider?.setValue(value, animated: animation)
        reloadData()
    }
    
    //MARK: Position
    private func minPosition() -> CGFloat {
        let trackRect : CGRect = (slider?.trackRect(forBounds: (slider?.bounds)!))!
        let thumbRect : CGRect = (slider?.thumbRect(forBounds: (slider?.bounds)!, trackRect: trackRect, value: (slider?.value)!))!
        
        return thumbRect.size.width/4.0
    }
    
    private func maxPosition() -> CGFloat {
        let trackRect : CGRect = (slider?.trackRect(forBounds: (slider?.bounds)!))!
        let thumbRect : CGRect = (slider?.thumbRect(forBounds: (slider?.bounds)!, trackRect: trackRect, value: (slider?.value)!))!
        return trackRect.size.width - thumbRect.size.width/4.0
    }
    
    private func defaultSliderPoint() -> CGPoint {
        let ranger : CGFloat = CGFloat(maximum - minimum)
        let minValue : CGFloat = CGFloat(skyLine - minimum)
        
        let currentX : CGFloat = minPosition() + (maxPosition() - minPosition())/(ranger * 1.0) * minValue
        return CGPoint(x: currentX, y: 0)
    }
    
    private func firstSliderPoint() -> CGPoint {
        let ranger : CGFloat = CGFloat(maximum - minimum)
        let minValue = CGFloat(current - minimum)
        
        let currentX : CGFloat = minPosition() + (maxPosition() - minPosition())/(ranger * 1.0) * minValue
        
        return CGPoint(x: currentX, y: 0)
    }
}

