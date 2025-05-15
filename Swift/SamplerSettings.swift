//
//  SamplerSettings.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import Foundation

struct SamplerSettings {
    var selectedSampler: AkaiSampler = .s1000
    var targetSampleRate: UInt32 = SamplerDefaults.defaultSampleRate(for: .s1000)
    var targetBitDepth: UInt8 = SamplerDefaults.defaultBitDepth(for: .s1000)
    var forceMono: Bool = false

    mutating func update(for sampler: AkaiSampler) {
        selectedSampler = sampler
        targetSampleRate = SamplerDefaults.defaultSampleRate(for: sampler)
        targetBitDepth = SamplerDefaults.defaultBitDepth(for: sampler)
        forceMono = SamplerDefaults.isMonoOnly(for: sampler)
    }
}
