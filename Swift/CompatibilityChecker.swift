//
//  CompatibilityChecker.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//

import Foundation

struct CompatibilityResult {
    let isCompatible: Bool
    let warnings: [String]
    let needsConversion: Bool
}

class CompatibilityChecker {
    static func checkCompatibility(sampleRate: UInt32, bitDepth: UInt8, isStereo: Bool, sampler: AkaiSampler) -> CompatibilityResult {
        var warnings: [String] = []
        var needsConversion = false

        // Check sample rate
        if sampleRate > sampler.maxSampleRate {
            warnings.append("Sample rate \(sampleRate) Hz exceeds max for \(sampler.rawValue) (\(sampler.maxSampleRate) Hz)")
            needsConversion = true
        }

        // Check bit depth
        if !sampler.supportedBitDepths.contains(bitDepth) {
            warnings.append("Bit depth \(bitDepth)-bit not supported by \(sampler.rawValue)")
            needsConversion = true
        }

        // Check channel count
        if sampler.isMonoOnly && isStereo {
            warnings.append("\(sampler.rawValue) only supports mono, but stereo file was provided")
            needsConversion = true
        }

        let isCompatible = warnings.isEmpty
        return CompatibilityResult(isCompatible: isCompatible, warnings: warnings, needsConversion: needsConversion)
    }
}
