//
//  SamplingSettings.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

struct SamplingSettings {
    var sampleRate: UInt32
    var bitDepth: UInt8
    var isMono: Bool
    var normalize: Bool
    var trimSilence: Bool
    var addSilenceMs: UInt32
    var targetSampler: AkaiSampler

    init(
        sampleRate: UInt32 = 44100,
        bitDepth: UInt8 = 16,
        isMono: Bool = false,
        normalize: Bool = false,
        trimSilence: Bool = false,
        addSilenceMs: UInt32 = 0,
        targetSampler: AkaiSampler = .s1000
    ) {
        self.sampleRate = sampleRate
        self.bitDepth = bitDepth
        self.isMono = isMono
        self.normalize = normalize
        self.trimSilence = trimSilence
        self.addSilenceMs = addSilenceMs
        self.targetSampler = targetSampler
    }

    func effectiveSampleRate() -> UInt32 {
        return min(sampleRate, targetSampler.maxSampleRate)
    }

    func effectiveBitDepth() -> UInt8 {
        return targetSampler.supportedBitDepths.contains(bitDepth) ? bitDepth : targetSampler.supportedBitDepths.first ?? 16
    }

    func forceMonoIfNeeded() -> Bool {
        return targetSampler.isMonoOnly ? true : isMono
    }
}

