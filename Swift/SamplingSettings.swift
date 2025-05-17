//
//  SamplingSettings.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-XX.
//

import Foundation

struct SamplingSettings {
    var sampleRate: UInt32
    var bitDepth: UInt8
    var isMono: Bool
    var trimSilence: Bool

    init(for sampler: SamplerType) {
        self.sampleRate = SamplerType.Defaults.maxSampleRate(for: sampler)
        self.bitDepth = SamplerType.Defaults.supportedBitDepths(for: sampler).first ?? 16
        self.isMono = SamplerType.Defaults.isMonoOnly(for: sampler)
        self.trimSilence = false
    }
}
