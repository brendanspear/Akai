import Foundation
import AVFoundation

struct AudioCompatibilityResult {
    let isCompatible: Bool
    let issues: [String]
}

class AudioCompatibilityChecker {
    
    static func checkCompatibility(for url: URL, sampler: AkaiSampler) -> AudioCompatibilityResult {
        var issues: [String] = []
        
        guard let asset = AVURLAsset(url: url) as? AVAsset else {
            return AudioCompatibilityResult(isCompatible: false, issues: ["Could not read audio file."])
        }

        guard let track = asset.tracks(withMediaType: .audio).first else {
            return AudioCompatibilityResult(isCompatible: false, issues: ["No audio track found."])
        }
        
        let formatDescriptions = track.formatDescriptions as! [CMAudioFormatDescription]
        guard let formatDesc = formatDescriptions.first else {
            return AudioCompatibilityResult(isCompatible: false, issues: ["No audio format found."])
        }

        let asbd = CMAudioFormatDescriptionGetStreamBasicDescription(formatDesc)!.pointee
        
        let sampleRate = UInt32(asbd.mSampleRate)
        let channels = UInt8(asbd.mChannelsPerFrame)
        let bitDepth = UInt8(asbd.mBitsPerChannel)
        
        // Sample rate check
        if sampleRate > sampler.maxSampleRate {
            issues.append("Sample rate too high for \(sampler.rawValue) (max \(sampler.maxSampleRate) Hz).")
        }
        
        // Bit depth check
        if !sampler.supportedBitDepths.contains(bitDepth) {
            issues.append("Bit depth of \(bitDepth) not supported by \(sampler.rawValue).")
        }
        
        // Channel check
        if sampler.isMonoOnly && channels != 1 {
            issues.append("Stereo audio not supported by \(sampler.rawValue).")
        }
        
        return AudioCompatibilityResult(isCompatible: issues.isEmpty, issues: issues)
    }
}
