//
//  SamplerDefaults.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import Foundation

struct SamplerDefaults {
    static func defaultSampleRate(for sampler: AkaiSampler) -> UInt32 {
        switch sampler {
        case .s900:
            return 37500
        case .s1000:
            return 44100
        case .s3000:
            return 48000
        }
    }

    static func defaultBitDepth(for sampler: AkaiSampler) -> UInt8 {
        switch sampler {
        case .s900:
            return 12
        case .s1000, .s3000:
            return 16
        }
    }

    static func isMonoOnly(for sampler: AkaiSampler) -> Bool {
        return sampler == .s900
    }
}
