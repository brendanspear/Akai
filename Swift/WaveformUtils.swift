//
//  WaveformUtils.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation
import Accelerate

struct WaveformUtils {
    
    // Normalize samples to full scale (16-bit range)
    static func normalize(_ samples: inout [Int16]) {
        guard let maxSample = samples.map({ abs(Int($0)) }).max(), maxSample > 0 else { return }
        let scale = Float(Int16.max) / Float(maxSample)
        for i in 0..<samples.count {
            samples[i] = Int16(clamping: Float(samples[i]) * scale)
        }
    }
    
    // Trim leading and trailing silence
    static func trimSilence(_ samples: [Int16], threshold: Int16 = 300) -> [Int16] {
        var start = 0
        var end = samples.count - 1
        
        while start < samples.count && abs(samples[start]) < threshold {
            start += 1
        }
        while end > start && abs(samples[end]) < threshold {
            end -= 1
        }
        return Array(samples[start...end])
    }
    
    // Append silence to the end
    static func appendSilence(_ samples: [Int16], milliseconds: Int, sampleRate: UInt32) -> [Int16] {
        let sampleCount = Int((Float(sampleRate) / 1000.0) * Float(milliseconds))
        let padding = [Int16](repeating: 0, count: sampleCount)
        return samples + padding
    }
    
    // Detect whether the sample is stereo or mono based on data length and header info
    static func isStereo(channels: Int) -> Bool {
        return channels == 2
    }
    
    // Convert stereo to mono by averaging L and R channels
    static func convertStereoToMono(_ stereoSamples: [Int16]) -> [Int16] {
        guard stereoSamples.count % 2 == 0 else { return stereoSamples }
        var monoSamples = [Int16]()
        for i in stride(from: 0, to: stereoSamples.count, by: 2) {
            let average = Int((Int(stereoSamples[i]) + Int(stereoSamples[i + 1])) / 2)
            monoSamples.append(Int16(clamping: average))
        }
        return monoSamples
    }
}

