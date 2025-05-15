import Foundation
import AVFoundation

struct SamplerCompatibilityResult {
    let isCompatible: Bool
    let issues: [String]
}

class SamplerCompatibilityChecker {
    static func check(fileURL: URL, for sampler: AkaiSampler) -> SamplerCompatibilityResult {
        var issues: [String] = []

        let asset = AVAsset(url: fileURL)
        guard let format = asset.tracks(withMediaType: .audio).first?.formatDescriptions.first else {
            return SamplerCompatibilityResult(isCompatible: false, issues: ["Unable to read audio format."])
        }

        let audioFormat = CMAudioFormatDescriptionGetStreamBasicDescription(format as! CMAudioFormatDescription)?.pointee

        if let sampleRate = audioFormat?.mSampleRate {
            if sampleRate > Double(sampler.maxSampleRate) {
                issues.append("Sample rate \(Int(sampleRate))Hz exceeds max \(sampler.maxSampleRate)Hz for \(sampler.rawValue).")
            }
        } else {
            issues.append("Could not determine sample rate.")
        }

        if let channelCount = audioFormat?.mChannelsPerFrame {
            if sampler.isMonoOnly && channelCount > 1 {
                issues.append("\(sampler.rawValue) only supports mono audio, but this file is stereo.")
            }
        } else {
            issues.append("Could not determine channel count.")
        }

        // For simplicity, we assume bit depth from file extension or metadata in more advanced logic.
        // You could enhance this with actual sample decoding if needed.

        return SamplerCompatibilityResult(
            isCompatible: issues.isEmpty,
            issues: issues
        )
    }
}
