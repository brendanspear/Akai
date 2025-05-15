//
//  SilenceUtils.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import Foundation

struct SilenceUtils {

    /// Trim leading and trailing silence from sample buffer (defined as samples below a threshold)
    static func trimSilence(samples: [Int16], threshold: Int16 = 200) -> [Int16] {
        guard !samples.isEmpty else { return samples }

        let startIndex = samples.firstIndex { abs($0) > threshold } ?? 0
        let endIndex = samples.lastIndex { abs($0) > threshold } ?? (samples.count - 1)

        if startIndex >= endIndex {
            return [] // all silence
        }

        return Array(samples[startIndex...endIndex])
    }

    /// Add silence to the end of a sample buffer
    static func addSilence(to samples: [Int16], milliseconds: Int, sampleRate: UInt32, channels: Int) -> [Int16] {
        let totalSamplesToAdd = Int(Double(milliseconds) / 1000.0 * Double(sampleRate)) * channels
        let silenceBuffer = [Int16](repeating: 0, count: totalSamplesToAdd)
        return samples + silenceBuffer
    }
}
