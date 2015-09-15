//
//  ViewController.swift
//  MetalDemo
//
//  Created by tokwan on 8/29/15.
//  Copyright © 2015 alienxp03. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tester: Tester!
    let startingBit = 12
    let endingBit   = 24
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        measure()
    }
    
    func measure() {
        let gpuTester = GPUTester()
        let cpuTester = CPUTester()
        
        var total = 0
        for var count = 1 << self.startingBit; count <= ( 1 << self.endingBit); count <<= 1 {
            total += count
        }
        
        print("Calculating", total)

        executionTimeInterval("CPU pow()", {
            for var count = 1 << self.startingBit; count <= ( 1 << self.endingBit); count <<= 1 {
                cpuTester.pow(count)
            }
        })

        executionTimeInterval("GPU pow()", {
            for var count = 1 << self.startingBit; count <= ( 1 << self.endingBit); count <<= 1 {
                gpuTester.pow(count)
            }
        })

        print("Done!")
        exit(0)
    }
    
    func executionTimeInterval(name: String, _ block: () -> ()) {
        let start = CACurrentMediaTime()
        block()
        let end = CACurrentMediaTime()
        print(name, "\t:", end - start, "secs")
    }
}
