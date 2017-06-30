//
//  MotionData.swift
//  Fastest
//
//  Created by Borja Igartua Pastor on 27/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

struct MotionData: Equatable {
    var x: Double
    var y: Double
    var z: Double
    var timestamp: TimeInterval
    
    static func == (left: MotionData, right: MotionData) -> Bool {
        return left.x == right.x && left.y == right.y && left.z == right.z && left.timestamp == right.timestamp
    }
}
