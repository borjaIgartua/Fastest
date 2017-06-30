//
//  ParabolicMotion.swift
//  Fastest
//
//  Created by Borja Igartua Pastor on 28/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

class ParabolicMotion {
    let motionManager = MotionManager(updateInterval: 0.1)
    
    var initialValue: MotionData?
    var finalValue = MotionData(x: Double(Int.min), y: Double(Int.min), z: Double(Int.min), timestamp: Double(Int.min))
    
    func calculateParabolicMotion(completionHandler: @escaping (Double) -> ()) {
        
        self.motionManager.startAcelerometer { [unowned self] (motionData) in
            
            if motionData.x > 0.15 {
                
                if self.initialValue == nil {
                    self.initialValue = motionData
                }
                
                if motionData.x > self.finalValue.x {
                    self.finalValue = motionData
                }
                
            } else if motionData.x < -0.5 {
                
                self.motionManager.stopAcelerometer()
                let reach = self.calculateReach(initialMotionData: self.initialValue!, finalMotionData: self.finalValue)
                
                self.initialValue = nil
                self.finalValue = MotionData(x: Double(Int.min), y: Double(Int.min), z: Double(Int.min), timestamp: Double(Int.min))
                completionHandler(reach)
            }
        }
    }
    
    func calculateReach(initialMotionData: MotionData, finalMotionData: MotionData) -> Double {
        
        let t = finalMotionData.timestamp - initialMotionData.timestamp
        
        let sqr = sqrt( pow(finalMotionData.x, 2) + pow(finalMotionData.z, 2) )
        let angle = abs(atan(finalMotionData.y/sqr))
        
        let velx = finalMotionData.x * t
        
        var reach = ( pow(velx, 2) * sin(2 * angle) ) / 9.8
        
        let random = Double(arc4random_uniform(4))
        reach += random
        
        return reach
    }
}
