//
//  WaveformUtils.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-XX.
//

import Foundation

enum WaveformUtils {
    static func normalize(samples: [Int16]) -> [Int16] {
        guard let maxSample = samples.max(by: { abs($0) < abs($1) }), maxSample != 0 else {
            return samples
        }

        let normalizationFactor = Float(Int16.max) / Float(abs(maxSample))
        return samples.map { sample in
            Int16(clamping: Int(Float(sample) * normalizationFactor))
        }
    }
}
