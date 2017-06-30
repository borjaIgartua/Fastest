//
//  UnitDisplayView.swift
//  Fastest
//
//  Created by Borja Igartua Pastor on 28/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import UIKit

class UnitDisplayView: UIView {
    var topBar: BarDisplayView
    var topRightBar: BarDisplayView
    var bottomRightBar: BarDisplayView
    var middleBar: BarDisplayView
    var bottomBar: BarDisplayView
    var bottomLeftBar: BarDisplayView
    var topLeftBar: BarDisplayView
    
    var hideColor: UIColor
    var lightColor: UIColor?
    
    private var timer: Timer?
    private var loopCount: Int = 0
    
    init(color: UIColor) {
        
        self.hideColor = color
        self.topBar = BarDisplayView(color: color, position: .horizontal)
        self.topRightBar = BarDisplayView(color: color, position: .vertical)
        self.bottomRightBar = BarDisplayView(color: color, position: .vertical)
        self.middleBar = BarDisplayView(color: color, position: .horizontal)
        self.bottomBar = BarDisplayView(color: color, position: .horizontal)
        self.bottomLeftBar = BarDisplayView(color: color, position: .vertical)
        self.topLeftBar = BarDisplayView(color: color, position: .vertical)
        super.init(frame: CGRect.zero)
        
        self.initializeSubViews()        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.hideColor = UIColor.gray
        self.topBar = BarDisplayView(color: hideColor, position: .horizontal)
        self.topRightBar = BarDisplayView(color: hideColor, position: .vertical)
        self.bottomRightBar = BarDisplayView(color: hideColor, position: .vertical)
        self.middleBar = BarDisplayView(color: hideColor, position: .horizontal)
        self.bottomBar = BarDisplayView(color: hideColor, position: .horizontal)
        self.bottomLeftBar = BarDisplayView(color: hideColor, position: .vertical)
        self.topLeftBar = BarDisplayView(color: hideColor, position: .vertical)
        super.init(coder: aDecoder)
        
        self.initializeSubViews()
    }
    
    
    private func initializeSubViews() {
        
        self.backgroundColor = UIColor.clear
    
        self.topBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topBar)
        
        self.topRightBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topRightBar)

        self.bottomRightBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomRightBar)
        
        self.middleBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(middleBar)
        
        self.bottomBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomBar)
        
        self.bottomLeftBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomLeftBar)
        
        self.topLeftBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topLeftBar)
        
    }
    
    override func updateConstraints() {
        
        self.removeConstraints(self.constraints)
        super.updateConstraints()
     
        let width = self.bounds.size.width
        let widthScale = width/4
        let horizontalBarWidth = width - (widthScale)
        let horizontalBarHeight = widthScale
        
        let verticalBarWidth = widthScale
        let verticalBarHeight = ((2 * width) - (widthScale)) / 2
        let barMargin = (widthScale) / 2
        
        let views = ["topBar" : topBar, "topRightBar" : topRightBar, "bottomRightBar" : bottomRightBar, "middleBar" : middleBar, "bottomBar" : bottomBar, "bottomLeftBar" : bottomLeftBar, "topLeftBar" : topLeftBar]
        let metrics = ["HBW": horizontalBarWidth, "HBH": horizontalBarHeight, "VBW": verticalBarWidth, "VBH": verticalBarHeight, "BM": barMargin]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-BM-[topBar]-BM-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[topBar(==HBH)]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-BM-[bottomBar]-BM-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-BM-[middleBar]-BM-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[topLeftBar(==VBW)]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomLeftBar(==VBW)]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[topRightBar(==VBW)]|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[bottomRightBar(==VBW)]|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-BM-[topRightBar(==VBH)][bottomRightBar]-BM-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-BM-[topLeftBar(==VBH)][bottomLeftBar]-BM-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bottomBar(==HBH)]|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[middleBar(==HBH)]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        self.addConstraint(NSLayoutConstraint(item: middleBar,
                                              attribute: NSLayoutAttribute.centerY,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.centerY,
                                              multiplier: 1.0,
                                              constant: 0))
        
        
        super.updateConstraints()
    }
    
    func animate(tillNumber number: Int) {
        
        loopCount = 0
        
        timer = Timer(timeInterval: 0.25,
                      target: self,
                      selector: #selector(UnitDisplayView.loopDraw(_:)),
                      userInfo: ["limit": number],
                      repeats: true)
        
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    @objc private func loopDraw(_ timer: Timer) {
        
        let userInfo = timer.userInfo as! [String:Int]
        let limit = userInfo["limit"]
        
        if limit! >= loopCount {
            
            self.draw(number: loopCount)
            loopCount += 1
            
        } else {
            timer.invalidate()
        }
    }
    
    func draw(number: Int) {
        
        switch number {
        case 0:
            self.changeBarColor(top: true, topRight: true, bottomRight: true, bottom: true, bottomLeft: true, topLeft: true, middle: false)
        case 1:
            self.changeBarColor(top: false, topRight: true, bottomRight: true, bottom: false, bottomLeft: false, topLeft: false, middle: false)
        case 2:
            self.changeBarColor(top: true, topRight: true, bottomRight: false, bottom: true, bottomLeft: true, topLeft: false, middle: true)
        case 3:
            self.changeBarColor(top: true, topRight: true, bottomRight: true, bottom: true, bottomLeft: false, topLeft: false, middle: true)
        case 4:
            self.changeBarColor(top: false, topRight: true, bottomRight: true, bottom: false, bottomLeft: false, topLeft: true, middle: true)
        case 5:
            self.changeBarColor(top: true, topRight: false, bottomRight: true, bottom: true, bottomLeft: false, topLeft: true, middle: true)
        case 6:
            self.changeBarColor(top: true, topRight: false, bottomRight: true, bottom: true, bottomLeft: true, topLeft: true, middle: true)
        case 7:
            self.changeBarColor(top: true, topRight: true, bottomRight: true, bottom: false, bottomLeft: false, topLeft: false, middle: false)
        case 8:
            self.changeBarColor(top: true, topRight: true, bottomRight: true, bottom: true, bottomLeft: true, topLeft: true, middle: true)
        case 9:
            self.changeBarColor(top: true, topRight: true, bottomRight: true, bottom: true, bottomLeft: false, topLeft: true, middle: true)
        default:
            break
        }
    }
    
    func reset() {
        self.changeBarColor(top: false, topRight: false, bottomRight: false, bottom: false, bottomLeft: false, topLeft: false, middle: false)
    }
    
    private func changeBarColor(top: Bool, topRight: Bool, bottomRight: Bool, bottom: Bool, bottomLeft: Bool, topLeft: Bool, middle: Bool) {
        
        self.topBar.change(color: top ? lightColor! : hideColor)
        self.topRightBar.change(color: topRight ? lightColor! : hideColor)
        self.bottomRightBar.change(color: bottomRight ? lightColor! : hideColor)
        self.middleBar.change(color: middle ? lightColor! : hideColor)
        self.bottomBar.change(color: bottom ? lightColor! : hideColor)
        self.bottomLeftBar.change(color: bottomLeft ? lightColor! : hideColor)
        self.topLeftBar.change(color: topLeft ? lightColor! : hideColor)
    }
}
