
// SamplerType+Defaults.swift
// AkaiSConvert

import Foundation

extension SamplerType {
    
    var defaultSampleRate: Int {
        switch self {
        case .s900: return 4000
        case .s950: return 10000
        case .s1000: return 44100
        case .s3000: return 44100
        }
    }

    var defaultBitDepth: Int {
        switch self {
        case .s900: return 12
        case .s950: return 12
        case .s1000: return 16
        case .s3000: return 16
        }
    }

    var defaultFormat: SampleFormat {
        switch self {
        case .s900, .s950: return .pcm12
        case .s1000, .s3000: return .pcm16
        }
    }
}
