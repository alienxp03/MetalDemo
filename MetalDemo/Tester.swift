//
//  Tester.swift
//  MetalDemo
//
//  Created by tokwan on 9/13/15.
//  Copyright © 2015 alienxp03. All rights reserved.
//

import UIKit
import Metal

protocol Tester {
    func pow(size: Int) -> [Float]
    func initMetal() -> (MTLDevice, MTLCommandQueue, MTLLibrary, MTLCommandBuffer, MTLComputeCommandEncoder)
}

extension Tester {
    func initMetal() -> (MTLDevice, MTLCommandQueue, MTLLibrary, MTLCommandBuffer, MTLComputeCommandEncoder) {
        let device                  = MTLCreateSystemDefaultDevice()!
        let commandQueue            = device.newCommandQueue()
        let defaultLibrary          = device.newDefaultLibrary()!
        let commandBuffer           = commandQueue.commandBuffer()
        let computeCommandEncoder   = commandBuffer.computeCommandEncoder()
        return (device, commandQueue, defaultLibrary, commandBuffer, computeCommandEncoder)
    }
}