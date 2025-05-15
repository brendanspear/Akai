//  AkaiProcessor.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.

import Foundation

class AkaiProcessor {

    static func checkCompatibility(samples: [Int16], sampleRate: UInt32, bitDepth: UInt8, sampler: AkaiSampler) -> Bool {
        let sampleCount = samples.count

        switch sampler {
        case .s900:
            return akai_check_compatibility_s900(samples, sampleCount, sampleRate, bitDepth) == 1
        case .s1000:
            return akai_check_compatibility_s1000(samples, sampleCount, sampleRate, bitDepth) == 1
        case .s3000:
            return akai_check_compatibility_s3000(samples, sampleCount, sampleRate, bitDepth) == 1
        }
    }

    static func convertSamplesTo12bit(inputSamples: [Int16], model: AkaiSampler) -> [UInt8]? {
        var output = [UInt8](repeating: 0, count: inputSamples.count * 2) // approximate size
        let convertedCount = inputSamples.withUnsafeBufferPointer { inPtr in
            output.withUnsafeMutableBufferPointer { outPtr in
                akai_convert_16bit_to_12bit(inPtr.baseAddress, inputSamples.count, outPtr.baseAddress, output.count)
            }
        }
        return convertedCount > 0 ? Array(output.prefix(Int(convertedCount))) : nil
    }

    static func convertSamplesTo16bit(inputData: [UInt8], model: AkaiSampler) -> [Int16]? {
        var output = [Int16](repeating: 0, count: inputData.count) // max possible size
        let convertedCount = inputData.withUnsafeBufferPointer { inPtr in
            output.withUnsafeMutableBufferPointer { outPtr in
                akai_convert_12bit_to_16bit(inPtr.baseAddress, inputData.count, outPtr.baseAddress, output.count)
            }
        }
        return convertedCount > 0 ? Array(output.prefix(Int(convertedCount))) : nil
    }

}
