//
//  AudioNormalizer.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import Foundation
import Accelerate

class AudioNormalizer {
    
    /// Normalizes a buffer of Int16 audio samples to use the full dynamic range.
    /// - Parameter samples: The original audio samples.
    /// - Returns: Normalized samples as Int16.
    static func normalize(samples: [Int16]) -> [Int16] {
        guard !samples.isEmpty else { return samples }
        
        let maxSample = samples.map { abs(Int32($0)) }.max() ?? 1
        guard maxSample > 0 else { return samples }
        
        let scale = Double(Int16.max) / Double(maxSample)
        
        return samples.map { Int16(Double($0) * scale) }
    }
}
