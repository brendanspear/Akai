//
//  SampleNormalizer.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//

import Foundation

class SampleNormalizer {
    
    /// Normalize 16-bit PCM samples to full scale
    static func normalize(samples: [Int16]) -> [Int16] {
        guard let maxSample = samples.map({ abs(Int($0)) }).max(), maxSample > 0 else {
            return samples
        }

        let normalizationFactor = 32767.0 / Double(maxSample)

        return samples.map { sample in
            let normalized = Double(sample) * normalizationFactor
            return Int16(max(min(normalized, 32767.0), -32768.0))
        }
    }

    /// Calculate normalization gain in dB
    static func calculateGain(samples: [Int16]) -> Double {
        guard let maxSample = samples.map({ abs(Int($0)) }).max(), maxSample > 0 else {
            return 0.0
        }

        let gain = 32767.0 / Double(maxSample)
        return 20.0 * log10(gain)
    }
}
