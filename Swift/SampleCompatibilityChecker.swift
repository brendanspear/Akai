//
//  SampleCompatibilityChecker.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

class SampleCompatibilityChecker {
    struct CompatibilityResult {
        var isCompatible: Bool
        var issues: [String]
    }

    static func check(sampleRate: UInt32, bitDepth: UInt8, channels: UInt8, for sampler: AkaiSampler) -> CompatibilityResult {
        var issues = [String]()

        if sampleRate > sampler.maxSampleRate {
            issues.append("Sample rate exceeds max for \(sampler.rawValue): \(sampleRate)Hz > \(sampler.maxSampleRate)Hz")
        }

        if !sampler.supportedBitDepths.contains(bitDepth) {
            issues.append("Unsupported bit depth for \(sampler.rawValue): \(bitDepth)-bit")
        }

        if sampler.isMonoOnly && channels > 1 {
            issues.append("\(sampler.rawValue) only supports mono audio")
        }

        return CompatibilityResult(
            isCompatible: issues.isEmpty,
            issues: issues
        )
    }
}

