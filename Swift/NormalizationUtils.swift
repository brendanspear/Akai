//
//  NormalizationUtils.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import Foundation

struct NormalizationUtils {

    /// Normalize sample buffer to full 16-bit range
    static func normalize(samples: [Int16]) -> [Int16] {
        guard let maxAmplitude = samples.map({ abs(Int($0)) }).max(), maxAmplitude > 0 else {
            return samples // No need to normalize if all zero or silent
        }

        let normalizationFactor = Double(Int16.max) / Double(maxAmplitude)
        return samples.map { Int16(clamping: Int(Double($0) * normalizationFactor)) }
    }

    /// Preview normalized audio level without modifying original
    static func previewGainAdjustment(for samples: [Int16]) -> Double {
        guard let maxAmplitude = samples.map({ abs(Int($0)) }).max(), maxAmplitude > 0 else {
            return 1.0 // No gain change needed
        }

        return Double(Int16.max) / Double(maxAmplitude)
    }
}

