//
//  NumbersDisplayView.swift
//  Fastest
//
//  Created by Borja Igartua Pastor on 28/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import UIKit

class NumbersDisplayView: UIView {
    let firstDigitView = UnitDisplayView(color: UIColor.numbersGray)
    let secondDigitView = UnitDisplayView(color: UIColor.numbersGray)
    let thirdDigitView = UnitDisplayView(color: UIColor.numbersGray)
    let fourthDigitView  = UnitDisplayView(color: UIColor.numbersGray)
    let decimalPointView = UIView()
    let contentView = UIView()
    
    typealias CompletionHandler = () -> ()
    var animateCompletionHandler: CompletionHandler?
    
    private var timer: Timer?
    private var loopCount: Double = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initializeSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initializeSubViews()
    }
    
    private func initializeSubViews() {
        
        self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = 13.0
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentView)
        
        firstDigitView.translatesAutoresizingMaskIntoConstraints = false
        firstDigitView.lightColor = UIColor.numbersLightGray
        contentView.addSubview(firstDigitView)
        
        secondDigitView.translatesAutoresizingMaskIntoConstraints = false
        secondDigitView.lightColor = UIColor.numbersLightGray
        contentView.addSubview(secondDigitView)
        
        decimalPointView.translatesAutoresizingMaskIntoConstraints = false
        decimalPointView.backgroundColor = UIColor.numbersGray
        contentView.addSubview(decimalPointView)
        
        thirdDigitView.translatesAutoresizingMaskIntoConstraints = false
        thirdDigitView.lightColor = UIColor.numbersLightGray
        contentView.addSubview(thirdDigitView)
        
        fourthDigitView.translatesAutoresizingMaskIntoConstraints = false
        fourthDigitView.lightColor = UIColor.numbersLightGray
        contentView.addSubview(fourthDigitView)
        
        let numbersWidth = self.bounds.width/4 - (5+5)
        
        let views = ["contentView": contentView,"firstDigitView": firstDigitView, "secondDigitView": secondDigitView, "thirdDigitView": thirdDigitView, "fourthDigitView": fourthDigitView, "decimalPointView": decimalPointView]
        let metrics = ["width" : numbersWidth]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView]|", options: [], metrics: nil, views: views))
        self.addConstraint(NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[firstDigitView(==width)]-5-[secondDigitView(==width)]-15-[thirdDigitView(==width)]-5-[fourthDigitView(==width)]|",
                                                           options: NSLayoutFormatOptions.alignAllCenterY,
                                                           metrics: metrics,
                                                           views: views))
        contentView.addConstraint(NSLayoutConstraint(item: firstDigitView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0))
        
        contentView.addConstraint(NSLayoutConstraint(item: firstDigitView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: firstDigitView, attribute: NSLayoutAttribute.width, multiplier: 2, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: secondDigitView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: secondDigitView, attribute: NSLayoutAttribute.width, multiplier: 2, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: thirdDigitView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: thirdDigitView, attribute: NSLayoutAttribute.width, multiplier: 2, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: fourthDigitView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: fourthDigitView, attribute: NSLayoutAttribute.width, multiplier: 2, constant: 0))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[secondDigitView]-2-[decimalPointView]", options: .alignAllBottom, metrics: nil, views: views))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[decimalPointView(==10)]", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[decimalPointView(==10)]", options: [], metrics: nil, views: views))
        
        contentView.layoutIfNeeded()
        self.layoutIfNeeded()
        
        firstDigitView.setNeedsUpdateConstraints()
        secondDigitView.setNeedsUpdateConstraints()
        thirdDigitView.setNeedsUpdateConstraints()
        fourthDigitView.setNeedsUpdateConstraints()
    }
    
    func animate(tillNumber number: Double, completion: @escaping CompletionHandler) {
        
        self.animateCompletionHandler = completion
        decimalPointView.backgroundColor = UIColor.numbersLightGray
        loopCount = 0.0
        timer = Timer(timeInterval: 0.02,
                      target: self,
                      selector: #selector(NumbersDisplayView.loopDraw(_:)),
                      userInfo: ["limit": number],
                      repeats: true)
        
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    @objc private func loopDraw(_ timer: Timer) {
        
        let userInfo = timer.userInfo as! [String:Double]
        let limit = userInfo["limit"]
        
        if limit! >= loopCount {
            
            self.draw(number: loopCount)
            loopCount += 0.01
            loopCount = loopCount.roundTo2
            
        } else {
            timer.invalidate()
            self.animateCompletionHandler?()
        }
    
    }
    
    func draw(number: Double) {
        
        let parts = number.separate()
        
        let firstNumber = parts.integerPart[0]
        let secondNumber = parts.integerPart[1]
        
        firstDigitView.draw(number: Int(firstNumber)!)
        secondDigitView.draw(number: Int(secondNumber)!)
        
        let firstDecimalNumber = parts.decimalPart[0]
        let secondDecimalNumber = parts.decimalPart[1]

        thirdDigitView.draw(number: Int(firstDecimalNumber)!)
        fourthDigitView.draw(number: Int(secondDecimalNumber)!)
    }
    
    func reset() {
        decimalPointView.backgroundColor = UIColor.numbersGray
        firstDigitView.reset()
        secondDigitView.reset()
        thirdDigitView.reset()
        fourthDigitView.reset()
    }

}
