//
//  LeftRightColor.swift
//  LeftRightSlider
//
//  Created by TienLe on 10/17/17.
//  Copyright © 2017 TL. All rights reserved.
//

import Foundation
import UIKit

class LeftRightColor: UIView {
    
    var trackView : UIView?
    var runningView : UIView?
    var trackColor : UIColor = UIColor.clear
    var runingColor : UIColor = UIColor.clear
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        trackView?.layoutIfNeeded()
        runningView?.layoutIfNeeded()
    }
    
    func setupRunningView(frame: CGRect) -> Void {
        if runningView != nil {
            runningView?.removeFromSuperview()
            runningView = nil
        }
        
        guard frame.size.width > 0 else {
            return
        }
        
        runningView = UIView.init(frame: frame)
        runningView?.backgroundColor = runingColor
        self.addSubview(runningView!)
        
        runningView?.makeBorder(sizeCornor: 4.0, borderWidth: 0.0, borderColor: nil)
        
        runningView?.frame = CGRect(x: frame.origin.x,
                                    y: self.frame.size.height/2.0 - frame.size.height/2.0,
                                    width: frame.size.width,
                                    height: frame.size.height)
        runningView?.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
    }
    
    func setupTrackView(frame: CGRect) -> Void {
        if trackView != nil {
            trackView?.removeFromSuperview()
            trackView = nil
        }
        guard frame.size.width > 0 else {
            return
        }
        
        trackView = UIView.init(frame: frame)
        trackView?.backgroundColor = trackColor
        trackView?.makeBorder(sizeCornor: 4.0, borderWidth: 0.0, borderColor: nil)
        
        self.addSubview(trackView!)
        
        let views = ["self" : self, "trackView": trackView!]
        let metrics = ["height" : frame.size.height]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:[self]-(<=0)-[trackView]", options: .alignAllCenterY, metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[trackView(==height)]", options: [], metrics: metrics, views: views))
    }
    
    func drawColor(_from startPoint: CGPoint, _to endPoint: CGPoint) -> Void {
        let width : CGFloat = endPoint.x - startPoint.x;
        var positionX : CGFloat = 0
        
        if startPoint.x < endPoint.x {
            positionX = startPoint.x
        } else {
            positionX = endPoint.x
        }
        runningView?.frame = CGRect(x: positionX,
                                    y: (runningView?.frame.origin.y)!,
                                    width: fabs(width),
                                    height: (runningView?.frame.size.height)!)
    }
}
