//
//  AkaiProcessor.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//  Based on original work by Klaus Michael Indlekofer under GPL v3.0.
//

import Foundation

class AkaiProcessor {

    static func checkCompatibility(samples: [Int16], sampleRate: UInt32, bitDepth: Int, sampler: AkaiSampler) -> Bool {
        let count: Int32 = Int32(samples.count)
        return samples.withUnsafeBufferPointer { buffer in
            switch sampler {
            case .s900:
                return akai_check_compatibility_s900(buffer.baseAddress, count, sampleRate, UInt8(bitDepth)) != 0
            case .s1000:
                return akai_check_compatibility_s1000(buffer.baseAddress, count, sampleRate, UInt8(bitDepth)) != 0
            case .s3000:
                return akai_check_compatibility_s3000(buffer.baseAddress, count, sampleRate, UInt8(bitDepth)) != 0
            }
        }
    }

    static func convertSamplesTo12bit(samples: [Int16]) -> [UInt8] {
        var output = [UInt8](repeating: 0, count: samples.count)
        let result: Int32 = akai_convert_16bit_to_12bit(samples, Int32(samples.count), &output, Int32(output.count))
        return Array(output.prefix(Int(result)))
    }

    static func convertSamplesTo16bit(samples: [UInt8]) -> [Int16] {
        var output = [Int16](repeating: 0, count: samples.count * 2)
        let result: Int32 = akai_convert_12bit_to_16bit(samples, Int32(samples.count), &output, Int32(output.count))
        return Array(output.prefix(Int(result)))
    }
}
