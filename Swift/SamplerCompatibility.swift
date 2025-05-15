//
//  SamplerCompatibility.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import Foundation

struct SamplerCompatibility {
    let maxSampleRate: UInt32
    let supportedBitDepths: [UInt8]
    let isMonoOnly: Bool

    init(for sampler: AkaiSampler) {
        switch sampler {
        case .s900:
            self.maxSampleRate = 40000
            self.supportedBitDepths = [12]
            self.isMonoOnly = true
        case .s1000:
            self.maxSampleRate = 44100
            self.supportedBitDepths = [16]
            self.isMonoOnly = false
        case .s3000:
            self.maxSampleRate = 48000
            self.supportedBitDepths = [16]
            self.isMonoOnly = false
        }
    }

    func isSampleRateCompatible(_ rate: UInt32) -> Bool {
        return rate <= maxSampleRate
    }

    func isBitDepthCompatible(_ bitDepth: UInt8) -> Bool {
        return supportedBitDepths.contains(bitDepth)
    }

    func isChannelConfigurationCompatible(_ channels: UInt8) -> Bool {
        return !isMonoOnly || channels == 1
    }

    func describeIncompatibility(rate: UInt32, bitDepth: UInt8, channels: UInt8) -> [String] {
        var issues: [String] = []

        if !isSampleRateCompatible(rate) {
            issues.append("Sample rate \(rate) exceeds max of \(maxSampleRate) Hz")
        }
        if !isBitDepthCompatible(bitDepth) {
            issues.append("Bit depth \(bitDepth) is unsupported")
        }
        if !isChannelConfigurationCompatible(channels) {
            issues.append("Sampler only supports mono audio")
        }

        return issues
    }
}
