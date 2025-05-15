//
//  AudioSilenceTrimmer.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import Foundation

class AudioSilenceTrimmer {
    
    /// Trims silence from the beginning and end of the sample array.
    static func trimSilence(samples: [Int16], threshold: Int16 = 500) -> [Int16] {
        guard !samples.isEmpty else { return samples }

        var startIndex = 0
        var endIndex = samples.count - 1

        // Trim leading silence
        while startIndex < samples.count && abs(samples[startIndex]) < threshold {
            startIndex += 1
        }

        // Trim trailing silence
        while endIndex > startIndex && abs(samples[endIndex]) < threshold {
            endIndex -= 1
        }

        if startIndex >= endIndex {
            return []
        }

        return Array(samples[startIndex...endIndex])
    }

    /// Appends silence (zeroes) to the beginning and end of the sample array.
    static func appendSilence(to samples: [Int16], milliseconds: Int, sampleRate: UInt32) -> [Int16] {
        let samplesToAdd = Int((Float(milliseconds) / 1000.0) * Float(sampleRate))
        let silence = [Int16](repeating: 0, count: samplesToAdd)
        return silence + samples + silence
    }
}
