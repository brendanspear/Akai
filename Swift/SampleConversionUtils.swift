//
//  SampleConversionUtils.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import Foundation
import AVFoundation

struct SampleConversionUtils {
    
    // Convert stereo to mono by averaging two channels
    static func convertStereoToMono(samples: [Int16], channels: Int) -> [Int16] {
        guard channels == 2 else { return samples } // Already mono
        var monoSamples = [Int16]()
        for i in stride(from: 0, to: samples.count, by: 2) {
            let avg = Int((Int(samples[i]) + Int(samples[i + 1])) / 2)
            monoSamples.append(Int16(avg))
        }
        return monoSamples
    }

    // Normalize sample amplitude to max peak (non-destructive peak normalization)
    static func normalize(samples: [Int16]) -> [Int16] {
        guard let max = samples.map({ abs(Int($0)) }).max(), max > 0 else {
            return samples
        }
        let scale = Double(Int16.max) / Double(max)
        return samples.map { Int16(Double($0) * scale) }
    }

    // Trim silence at beginning and end (within threshold)
    static func trimSilence(samples: [Int16], threshold: Int16 = 500) -> [Int16] {
        var start = 0
        var end = samples.count - 1

        while start < end && abs(samples[start]) < threshold {
            start += 1
        }

        while end > start && abs(samples[end]) < threshold {
            end -= 1
        }

        return Array(samples[start...end])
    }

    // Add silence at the end of a sample (in milliseconds)
    static func appendSilence(samples: [Int16], sampleRate: Int, milliseconds: Int) -> [Int16] {
        let silentSamples = Int(Double(sampleRate) * Double(milliseconds) / 1000.0)
        let padding = [Int16](repeating: 0, count: silentSamples)
        return samples + padding
    }

    // Utility to check and convert unsupported sample rate/bit depth
    static func convertSampleRateIfNeeded(samples: [Int16], currentRate: Int, targetRate: Int) -> [Int16] {
        guard currentRate != targetRate else { return samples }

        // Simple downsampling (not high-quality, but functional)
        let ratio = Double(currentRate) / Double(targetRate)
        let downsampled = stride(from: 0, to: Double(samples.count), by: ratio).map { samples[Int($0)] }
        return downsampled
    }
}

