//
//  AudioUtils.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import Foundation
import AVFoundation

enum AudioUtils {
    
    /// Normalize 16-bit PCM samples to full scale (-32768 to 32767)
    static func normalize(_ samples: inout [Int16]) {
        guard let maxAmplitude = samples.map({ abs(Int32($0)) }).max(), maxAmplitude > 0 else { return }
        let scale = 32767.0 / Float(maxAmplitude)
        for i in 0..<samples.count {
            samples[i] = Int16(Float(samples[i]) * scale)
        }
    }

    /// Trim leading and trailing silence (zero or near-zero amplitude)
    static func trimSilence(_ samples: inout [Int16], threshold: Int16 = 10) {
        let startIndex = samples.firstIndex(where: { abs($0) > threshold }) ?? 0
        let endIndex = samples.lastIndex(where: { abs($0) > threshold }) ?? (samples.count - 1)
        if startIndex <= endIndex {
            samples = Array(samples[startIndex...endIndex])
        } else {
            samples.removeAll()
        }
    }

    /// Add N milliseconds of silence to the end of the sample
    static func addSilenceTail(_ samples: inout [Int16], ms: Int, sampleRate: Int) {
        let sampleCount = (sampleRate * ms) / 1000
        samples.append(contentsOf: [Int16](repeating: 0, count: sampleCount))
    }

    /// Convert stereo samples to mono by averaging L & R
    static func convertStereoToMono(_ stereoSamples: [Int16]) -> [Int16] {
        guard stereoSamples.count % 2 == 0 else { return stereoSamples } // must be even
        var monoSamples = [Int16]()
        monoSamples.reserveCapacity(stereoSamples.count / 2)
        for i in stride(from: 0, to: stereoSamples.count, by: 2) {
            let avg = Int32(stereoSamples[i]) + Int32(stereoSamples[i + 1])
            monoSamples.append(Int16(avg / 2))
        }
        return monoSamples
    }

    /// Check whether the audio is stereo based on channel count
    static func isStereo(channelCount: Int) -> Bool {
        return channelCount == 2
    }
}

