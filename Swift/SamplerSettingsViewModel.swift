//
//  SamplerSettingsViewModel.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-XX.
//

import Foundation

class SamplerSettingsViewModel: ObservableObject {
    @Published var sampler: SamplerType = .s1000

    var isMonoOnly: Bool {
        SamplerType.Defaults.isMonoOnly(for: sampler)
    }

    var maxSampleRate: UInt32 {
        SamplerType.Defaults.maxSampleRate(for: sampler)
    }

    var supportedBitDepths: [UInt8] {
        SamplerType.Defaults.supportedBitDepths(for: sampler)
    }
}
