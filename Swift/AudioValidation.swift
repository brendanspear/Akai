//
//  AudioValidation.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation
import AVFoundation

struct AudioValidationResult {
    let isValid: Bool
    let issues: [String]
}

class AudioValidator {
    
    static func validateFile(at url: URL, for sampler: AkaiSampler) -> AudioValidationResult {
        var issues: [String] = []
        var isValid = true
        
        let asset = AVAsset(url: url)
        guard let format = asset.tracks(withMediaType: .audio).first?.formatDescriptions.first as? CMAudioFormatDescription,
              let asbd = CMAudioFormatDescriptionGetStreamBasicDescription(format)?.pointee else {
            return AudioValidationResult(isValid: false, issues: ["Unable to read audio format."])
        }
        
        // Channels
        let channels = Int(asbd.mChannelsPerFrame)
        if sampler.isMonoOnly && channels > 1 {
            issues.append("Stereo files are not supported on \(sampler.rawValue).")
            isValid = false
        }
        
        // Sample Rate
        let sampleRate = UInt32(asbd.mSampleRate)
        if sampleRate > sampler.maxSampleRate {
            issues.append("Sample rate \(sampleRate)Hz exceeds max allowed \(sampler.maxSampleRate)Hz for \(sampler.rawValue).")
            isValid = false
        }
        
        // Bit Depth
        let bitDepth = UInt8(asbd.mBitsPerChannel)
        if !sampler.supportedBitDepths.contains(bitDepth) {
            issues.append("Bit depth \(bitDepth)-bit is not supported on \(sampler.rawValue).")
            isValid = false
        }
        
        return AudioValidationResult(isValid: isValid, issues: issues)
    }
}

