//
//  CPUTester.swift
//  MetalDemo
//
//  Created by tokwan on 9/13/15.
//  Copyright © 2015 alienxp03. All rights reserved.
//

import UIKit

class CPUTester: Tester {
    func pow(size: Int) -> [Float] {
        var vector = [Float](count: size, repeatedValue: 0)
        for (index, _) in vector.enumerate() {
            vector[index] = Float(index)
        }
        
        for (index, _) in vector.enumerate() {
            vector[index] = powf(vector[index], 3)
        }
        
        return vector
    }
}
