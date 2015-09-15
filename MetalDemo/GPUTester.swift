//
//  GPUTester.swift
//  MetalDemo
//
//  Created by tokwan on 9/13/15.
//  Copyright © 2015 alienxp03. All rights reserved.
//

import UIKit

class GPUTester: Tester {
    func pow(size: Int) -> [Float] {
        var vector = [Float](count: size, repeatedValue: 0)
        for (index, _) in vector.enumerate() {
            vector[index] = Float(index)
        }
        
        let (device, _, defaultLibrary, commandBuffer, computeCommandEncoder) = initMetal()
        
        let sigmoidProgram = defaultLibrary.newFunctionWithName("pow")
        let computePipelineFilter = try! device.newComputePipelineStateWithFunction(sigmoidProgram!)
        computeCommandEncoder.setComputePipelineState(computePipelineFilter)
        
        let vectorByteLength = vector.count * sizeofValue(vector[0])
        
        let inVectorBuffer = device.newBufferWithBytes(&vector, length: vectorByteLength, options: .CPUCacheModeWriteCombined)
        computeCommandEncoder.setBuffer(inVectorBuffer, offset: 0, atIndex: 0)
        
        var resultdata = [Float](count:vector.count, repeatedValue: 0)
        let outVectorBuffer = device.newBufferWithBytes(&resultdata, length: vectorByteLength, options: .CPUCacheModeWriteCombined)
        computeCommandEncoder.setBuffer(outVectorBuffer, offset: 0, atIndex: 1)
        
        let threadsPerGroup = MTLSize(width:32, height:1, depth:1)
        let numThreadgroups = MTLSize(width:(vector.count + 31) / 32, height:1, depth:1)
        computeCommandEncoder.dispatchThreadgroups(numThreadgroups, threadsPerThreadgroup: threadsPerGroup)
        
        computeCommandEncoder.endEncoding()
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()
        
        let data = NSData(bytesNoCopy: outVectorBuffer.contents(),
            length: vector.count*sizeof(Float), freeWhenDone: false)
        var finalResultArray = [Float](count: vector.count, repeatedValue: 0)
        data.getBytes(&finalResultArray, length:vector.count * sizeof(Float))

        return finalResultArray
    }
}
