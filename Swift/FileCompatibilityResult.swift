//
//  FileCompatibilityResult.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

struct FileCompatibilityResult {
    let isCompatible: Bool
    let issues: [String]

    static func check(sampleRate: UInt32, bitDepth: UInt8, isStereo: Bool, sampler: AkaiSampler) -> FileCompatibilityResult {
        var issues: [String] = []

        if sampleRate > sampler.maxSampleRate {
            issues.append("Sample rate exceeds \(sampler.rawValue) limit of \(sampler.maxSampleRate) Hz.")
        }

        if !sampler.supportedBitDepths.contains(bitDepth) {
            issues.append("Bit depth \(bitDepth) is not supported by \(sampler.rawValue).")
        }

        if isStereo && sampler.isMonoOnly {
            issues.append("\(sampler.rawValue) only supports mono audio.")
        }

        return FileCompatibilityResult(
            isCompatible: issues.isEmpty,
            issues: issues
        )
    }

    var description: String {
        if isCompatible {
            return "This file is compatible with the selected sampler."
        } else {
            return "Incompatibilities detected:\n" + issues.joined(separator: "\n")
        }
    }
}

