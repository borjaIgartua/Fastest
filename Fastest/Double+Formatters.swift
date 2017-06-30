//
//  Double+Truncate.swift
//  Fastest
//
//  Created by Borja Igartua Pastor on 27/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

extension Double {
    
    var roundTo2: Double {
        
        let converter = NumberFormatter()
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.none
        formatter.roundingMode = .down
        formatter.maximumFractionDigits = 2
        
        if let stringFromDouble = formatter.string(from: NSNumber(value: self)) {
            if let doubleFromString = converter.number(from: stringFromDouble)?.doubleValue {
                return doubleFromString
            }
        }
        return 0
    }
    
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
    
    func separate() -> (integerPart: String, decimalPart: String) {
        
        let formattedNumber = self.roundTo2
        let numberOfPlaces:Double = 2.0
        let powerOfTen:Double = pow(10.0, numberOfPlaces)
        var targetedDecimalPlaces:Double = Darwin.round((formattedNumber.truncatingRemainder(dividingBy: 1.0)) * powerOfTen) / powerOfTen
        targetedDecimalPlaces = targetedDecimalPlaces.roundTo2
        let decimalPartString = String(format: "%.2f", targetedDecimalPlaces)
        
        let decimalSeparator = "."//NSLocale.current.decimalSeparator ?? "."
        let decimalPart = decimalPartString.components(separatedBy: decimalSeparator)[1]
        
        let parts = modf(formattedNumber)
        let integerPart = String(format: "%02d", Int(parts.0))
        
        return (integerPart, decimalPart)
    }
    
    func separateNumbers() -> (integerNumber: Int, decimalNumber: Int) {
        
        let parts = self.separate()        
        return (Int(parts.integerPart)!, Int(parts.decimalPart)!)
    }
}
