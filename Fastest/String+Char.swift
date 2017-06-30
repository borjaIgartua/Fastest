//
//  String+Char.swift
//  Fastest
//
//  Created by Borja Igartua Pastor on 29/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

extension String {
    
    subscript (i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)] as Character)
    }
}
