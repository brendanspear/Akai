//
//  AkaiProcessor.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//  Licensed under GNU General Public License v3.0
//
//  Some logic adapted from akaiutil by Klaus Michael Indlekofer (2008–2025)
//

import Foundation

class AkaiProcessor {

    static func checkCompatibility(samples: [Int16], sampleRate: UInt32, bitDepth: UInt8, sampler: AkaiSampler) -> Bool {
        let sampleCount = Int32(samples.count)

        switch sampler {
        case .s900:
            return akai_check_compatibility_s900(samples, sampleCount, sampleRate, bitDepth) == 1
        case .s1000:
            return akai_check_compatibility_s1000(samples, sampleCount, sampleRate, bitDepth) == 1
        case .s3000:
            return akai_check_compatibility_s3000(samples, sampleCount, sampleRate, bitDepth) == 1
            print("Type of result: \\(type(of: result))")
            
            print("Header import success! Returned:", test)
        }
    }

    static func convertSamplesTo12bit(inputSamples: [Int16], model: AkaiSampler) -> [UInt8]? {
        var output = [UInt8](repeating: 0, count: inputSamples.count * 2)
        var result: Int32 = 0

        inputSamples.withUnsafeBufferPointer { inPtr in
            output.withUnsafeMutableBufferPointer { outPtr in
                let cResult = akai_convert_16bit_to_12bit(
                    inPtr.baseAddress,
                    Int32(inputSamples.count),
                    outPtr.baseAddress,
                    Int32(output.count)
                )
                result = cResult
            }
        }

        if result > 0 {
            return Array(output.prefix(Int(result)))
        } else {
            return nil
        }
    }

    static func convertSamplesTo16bit(inputData: [UInt8], model: AkaiSampler) -> [Int16]? {
        var output = [Int16](repeating: 0, count: inputData.count)
        var result: Int32 = 0

        inputData.withUnsafeBufferPointer { inPtr in
            output.withUnsafeMutableBufferPointer { outPtr in
                let cResult = akai_convert_12bit_to_16bit(
                    inPtr.baseAddress,
                    Int32(inputData.count),
                    outPtr.baseAddress,
                    Int32(output.count)
                )
                result = cResult
            }
        }

        if result > 0 {
            return Array(output.prefix(Int(result)))
        } else {
            return nil
        }
    }
}
