//
//  Shaders.metal
//  MetalDemo
//
//  Created by tokwan on 8/29/15.
//  Copyright © 2015 alienxp03. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

kernel void pow(const device float *inVector [[ buffer(0) ]],
                       device float *outVector [[ buffer(1) ]],
                       uint id [[ thread_position_in_grid ]]) {
    outVector[id] = pow(inVector[id], 3);
}
