//
//  ViewController.swift
//  LeftRightSlider
//
//  Created by TienLe on 10/17/17.
//  Copyright © 2017 TL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var codeSlider : LeftRightSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.purple
        setupCodeSlider()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        codeSlider.layoutIfNeeded()
        codeSlider.reloadData()
    }
    
    func setupCodeSlider() -> Void {
        codeSlider = LeftRightSlider.init(frame: .zero)
        codeSlider.minimum = 0.0
        codeSlider.maximum = 10.0
        codeSlider.skyLine = 5.0
        codeSlider.current = 3.0
        codeSlider.selectedColor = UIColor.red
        codeSlider.unSelectedColor = UIColor.yellow
        codeSlider.sliderHeight = 3.0
        codeSlider.tlDelegate = self
        codeSlider.reloadData()
        
        self.view.addSubview(codeSlider)
        
        let views : [String : LeftRightSlider] = ["codeSlider" : codeSlider]
        
        codeSlider.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[codeSlider]-10-|", options: [], metrics: nil, views: views))
        
        let metrics = ["top" : 60, "height" : 40]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(top)-[codeSlider(height@999)]-(>=10@998)-|", options: [], metrics: metrics, views: views))
    }
}

extension ViewController : LeftRightSliderDelegate {
    func tlSlider(_slider : UISlider, changeToValue: Float) -> Void {
        
    }
    
    func tlSlider(_slider : UISlider, didEndSliding: Float) -> Void {
        
    }
}

