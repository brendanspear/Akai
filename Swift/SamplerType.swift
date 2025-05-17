//
//  SamplerType.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-XX.
//

import Foundation

enum SamplerType: String, Codable, CaseIterable {
    case s900
    case s1000
    case s3000

    struct Defaults {
        static func defaultSampleRate(for sampler: SamplerType) -> UInt32 {
            switch sampler {
            case .s900: return 4000
            case .s1000: return 44100
            case .s3000: return 44100
            }
        }

        static func defaultBitDepth(for sampler: SamplerType) -> UInt8 {
            switch sampler {
            case .s900: return 12
            case .s1000, .s3000: return 16
            }
        }

        static func isMonoOnly(for sampler: SamplerType) -> Bool {
            return sampler == .s900
        }

        static func maxSampleRate(for sampler: SamplerType) -> UInt32 {
            switch sampler {
            case .s900: return 4000
            case .s1000: return 44100
            case .s3000: return 48000
            }
        }

        static func supportedBitDepths(for sampler: SamplerType) -> [UInt8] {
            switch sampler {
            case .s900: return [12]
            case .s1000, .s3000: return [16]
            }
        }
    }
}
