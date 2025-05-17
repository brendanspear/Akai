//
//  SamplerSettings.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import Foundation

struct SamplerSettings {
    var selectedSampler: SamplerType = .s1000
    var targetSampleRate: UInt32 = SamplerType.Defaults.defaultSampleRate(for: .s1000)
    var targetBitDepth: UInt8 = SamplerType.Defaults.defaultBitDepth(for: .s1000)
    var forceMono: Bool = false

    mutating func update(for sampler: SamplerType) {
        selectedSampler = sampler
        targetSampleRate = SamplerType.Defaults.defaultSampleRate(for: sampler)
        targetBitDepth = SamplerType.Defaults.defaultBitDepth(for: sampler)
        forceMono = SamplerType.Defaults.isMonoOnly(for: sampler)
    }
}
