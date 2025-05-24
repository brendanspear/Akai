//
//  SamplerType+Properties.swift
//  AkaiSConvert
//

import Foundation

extension SamplerType {
    
    var isMonoOnly: Bool {
        switch self {
        case .s900, .s950:
            return true
        case .s1000, .s3000:
            return false
        }
    }

    var maxSampleRate: Int {
        switch self {
        case .s900:
            return 40000
        case .s950:
            return 48000
        case .s1000:
            return 44100
        case .s3000:
            return 48000
        }
    }

    var supportedBitDepths: [Int] {
        switch self {
        case .s900, .s950:
            return [12]
        case .s1000, .s3000:
            return [16]
        }
    }
    var supportedFormats: [SampleFormat] {
        switch self {
        case .s900, .s950:
            return [.pcm12]
        case .s1000, .s3000:
            return [.pcm16]
        }
    }
}
