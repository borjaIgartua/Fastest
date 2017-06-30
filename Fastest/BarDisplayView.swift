//
//  BarDisplayView.swift
//  Fastest
//
//  Created by Borja Igartua Pastor on 28/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import UIKit

class BarDisplayView: UIView {
    
    enum BarDisplayPosition {
        case horizontal
        case vertical
    }
    
    var position: BarDisplayPosition
    var color: UIColor
    
    
    init(color: UIColor, position: BarDisplayPosition) {
        
        self.position = position
        self.color = color
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.position = BarDisplayPosition.horizontal
        self.color = UIColor.gray
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.clear
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        let layer = CAShapeLayer()
        let path = UIBezierPath()
                
        if self.position == .vertical {
        
            let diagonalWidth = rect.size.width / 2
            path.move(to: CGPoint(x:rect.midX, y:rect.minY))
            path.addLine(to: CGPoint(x:rect.minX, y:rect.minY + diagonalWidth))
            path.addLine(to: CGPoint(x:rect.minX, y:rect.maxY - diagonalWidth))
            
            path.addLine(to: CGPoint(x:rect.midX, y:rect.maxY))
            
            path.addLine(to: CGPoint(x:rect.maxX, y:rect.maxY - diagonalWidth))
            path.addLine(to: CGPoint(x:rect.maxX, y:rect.minY + diagonalWidth))
            path.addLine(to: CGPoint(x:rect.midX, y:rect.minY))
            
        } else {

            let diagonalWidth = rect.size.height / 2
            path.move(to: CGPoint(x:rect.minX, y:rect.midY))
            path.addLine(to: CGPoint(x:rect.minX + diagonalWidth, y:rect.minY))
            path.addLine(to: CGPoint(x:rect.maxX - diagonalWidth, y:rect.minY))
            
            path.addLine(to: CGPoint(x:rect.maxX, y:rect.midY))
            path.addLine(to: CGPoint(x:rect.maxX - diagonalWidth, y:rect.maxY))
            path.addLine(to: CGPoint(x:rect.minX + diagonalWidth, y:rect.maxY))
            path.addLine(to: CGPoint(x:rect.minX, y:rect.midY))
        }
        
        path.close()
        
        UIColor.clear.set()
        path.stroke(with: CGBlendMode.luminosity, alpha: 1)
        
        path.fill(with: CGBlendMode.colorBurn, alpha: 1)
        
        layer.path = path.cgPath
        layer.fillColor = self.color.cgColor
        self.layer.addSublayer(layer)               
    }
    
    func change(color: UIColor) {
        
        if let shapeLayer = self.layer.sublayers?[0] as? CAShapeLayer {
            shapeLayer.fillColor = color.cgColor
        }
    }
}
