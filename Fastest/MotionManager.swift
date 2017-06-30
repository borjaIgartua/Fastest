//
//  MotionManager.swift
//  Fastest
//
//  Created by Borja Igartua Pastor on 27/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation
import CoreMotion

typealias UpdatedHandler = (MotionData) -> ()

struct MotionManager {
    let motionManager = CMMotionManager()
    
    init(updateInterval: TimeInterval) {
        
        motionManager.accelerometerUpdateInterval = updateInterval
        motionManager.gyroUpdateInterval = updateInterval
        motionManager.magnetometerUpdateInterval = updateInterval
    }
    
    func startAcelerometer(updatedHandler: @escaping UpdatedHandler) {
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (acelerometerData, error) in
            
            guard error == nil else {
                return
            }
            
            guard let acelerometerData = acelerometerData else {
                return
            }
            
            let acceleration = acelerometerData.acceleration
            updatedHandler(MotionData(x: acceleration.x, y: acceleration.y, z: acceleration.z, timestamp: acelerometerData.timestamp))
        }
    }
    
    func stopAcelerometer() {
        motionManager.stopAccelerometerUpdates()
    }
    
    func startGyro(updatedHandler: @escaping UpdatedHandler) {
        
        motionManager.startGyroUpdates(to: OperationQueue.current!) { (gyroData, error) in
            
            guard error == nil else {
                return
            }
            
            guard let gyroData = gyroData else {
                return
            }
            
            let rotationRate = gyroData.rotationRate
            updatedHandler(MotionData(x: rotationRate.x, y: rotationRate.y, z: rotationRate.z, timestamp: gyroData.timestamp))
        }
    }
    
    func stopGyro() {
        motionManager.stopGyroUpdates()
    }
    
    func startMagnetometer(updatedHandler: @escaping UpdatedHandler) {
        
        motionManager.startMagnetometerUpdates(to: OperationQueue.current!) { (magnetometerData, error) in
            
            guard error == nil else {
                return
            }
            
            guard let magnetometerData = magnetometerData else {
                return
            }
            
            let magneticField = magnetometerData.magneticField
            updatedHandler(MotionData(x: magneticField.x, y: magneticField.y, z: magneticField.z, timestamp: magnetometerData.timestamp))
        }
    }
    
    func stopMagnetometer() {
        motionManager.stopMagnetometerUpdates()
    }
}
