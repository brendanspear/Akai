//
//  CompatibilityAnalyzer.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import Foundation
import AVFoundation

class CompatibilityAnalyzer {
    
    static func analyze(_ sample: LoadedSample, for sampler: AkaiSampler) -> [String] {
        var issues: [String] = []

        // Check sample rate
        if sample.sampleRate > sampler.maxSampleRate {
            issues.append("Sample rate \(sample.sampleRate) exceeds maximum for \(sampler.rawValue) (\(sampler.maxSampleRate) Hz).")
        }

        // Check bit depth
        if !sampler.supportedBitDepths.contains(sample.bitDepth) {
            issues.append("Bit depth \(sample.bitDepth) not supported by \(sampler.rawValue).")
        }

        // Check channel count
        if sampler.isMonoOnly && sample.channels != 1 {
            issues.append("Stereo not supported by \(sampler.rawValue). Convert to mono.")
        }

        // Check duration
        let maxSeconds = sampler.maxSampleDurationSeconds
        if sample.duration > Double(maxSeconds) {            issues.append("Sample is too long for \(sampler.rawValue). Max allowed: \(maxSeconds) seconds.")
        }

        return issues
    }

    static func fix(_ sample: LoadedSample, for sampler: AkaiSampler) -> LoadedSample {
        var fixed = sample

        // Downmix to mono if needed
        if sampler.isMonoOnly && fixed.channels > 1 {
            fixed.data = AudioConverter.downmixStereoToMono(fixed.data)
            fixed.channels = 1
        }

        // Resample if needed
        if fixed.sampleRate > sampler.maxSampleRate {
            fixed.data = AudioConverter.resample(
                buffer: fixed.data,
                fromRate: fixed.sampleRate,
                toRate: sampler.maxSampleRate
            )
            fixed.sampleRate = sampler.maxSampleRate
        }

        // Adjust bit depth if needed
        if !sampler.supportedBitDepths.contains(fixed.bitDepth) {
            if sampler.supportedBitDepths.contains(12) {
                fixed.bitDepth = 12
            } else {
                fixed.bitDepth = sampler.supportedBitDepths.first ?? fixed.bitDepth
            }
        }

        return fixed
    }
}
