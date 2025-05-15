//
//  AudioUtility.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation
import AVFoundation

class AudioUtility {
    
    /// Normalize PCM16 audio samples to peak at 0 dB
    static func normalize(samples: inout [Int16]) {
        guard let maxSample = samples.map({ abs(Int32($0)) }).max(), maxSample > 0 else { return }
        let scale = 32767.0 / Double(maxSample)
        for i in samples.indices {
            samples[i] = Int16(Double(samples[i]) * scale)
        }
    }
    
    /// Convert stereo samples to mono by averaging the two channels
    static func convertStereoToMono(samples: [Int16]) -> [Int16] {
        var monoSamples: [Int16] = []
        var i = 0
        while i + 1 < samples.count {
            let left = samples[i]
            let right = samples[i + 1]
            let avg = Int16((Int32(left) + Int32(right)) / 2)
            monoSamples.append(avg)
            i += 2
        }
        return monoSamples
    }

    /// Trim silence (defined as near-zero amplitude) from the beginning and end of PCM16 samples
    static func trimSilence(samples: [Int16], threshold: Int16 = 100) -> [Int16] {
        let threshold = abs(threshold)
        let start = samples.firstIndex { abs($0) > threshold } ?? 0
        let end = samples.lastIndex { abs($0) > threshold } ?? (samples.count - 1)
        return Array(samples[start...end])
    }

    /// Add silence (zero-padding) to the end of the samples
    static func addSilence(to samples: [Int16], milliseconds: Int, sampleRate: Int) -> [Int16] {
        let silenceCount = Int(Double(milliseconds) * Double(sampleRate) / 1000.0)
        let padding = [Int16](repeating: 0, count: silenceCount)
        return samples + padding
    }
}

