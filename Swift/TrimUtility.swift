//
//  TrimUtility.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation
import AVFoundation

class TrimUtility {
    /// Trims silence (zero-value samples) from the start and end of an audio buffer.
    static func trimSilence(from samples: [Int16], threshold: Int16 = 10) -> [Int16] {
        var start = 0
        var end = samples.count - 1

        while start < samples.count && abs(samples[start]) <= threshold {
            start += 1
        }

        while end > start && abs(samples[end]) <= threshold {
            end -= 1
        }

        if start >= end {
            return [] // Entire file is silence
        }

        return Array(samples[start...end])
    }

    /// Adds silence (zero-value samples) to the end of the audio buffer.
    static func padSilence(to samples: [Int16], milliseconds: Int, sampleRate: UInt32) -> [Int16] {
        let silenceSampleCount = Int(Double(milliseconds) * Double(sampleRate) / 1000.0)
        let silence = [Int16](repeating: 0, count: silenceSampleCount)
        return samples + silence
    }
}

