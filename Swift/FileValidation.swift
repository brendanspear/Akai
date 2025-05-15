//
//  FileValidation.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import Foundation
import AVFoundation

struct FileValidationResult {
    let isCompatible: Bool
    let issues: [String]
    let suggestedFixes: [String]
}

class FileValidator {
    static func validateSampleFile(_ url: URL, for sampler: SamplerType) -> FileValidationResult {
        var issues: [String] = []
        var fixes: [String] = []

        let asset = AVAsset(url: url)
        guard let format = asset.tracks(withMediaType: .audio).first?.formatDescriptions.first else {
            return FileValidationResult(isCompatible: false, issues: ["Could not read audio format."], suggestedFixes: [])
        }

        guard let desc = format as? CMAudioFormatDescription,
              let asbd = CMAudioFormatDescriptionGetStreamBasicDescription(desc) else {
            return FileValidationResult(isCompatible: false, issues: ["Unsupported audio format."], suggestedFixes: [])
        }

        let sampleRate = UInt32(asbd.pointee.mSampleRate)
        let channels = Int(asbd.pointee.mChannelsPerFrame)
        let bitDepth = UInt8(asbd.pointee.mBitsPerChannel)

        if !sampler.supportedBitDepths.contains(bitDepth) {
            issues.append("Bit depth \(bitDepth) not supported by \(sampler.rawValue).")
            fixes.append("Convert to \(sampler.supportedBitDepths.first!) bit.")
        }

        if sampleRate > sampler.maxSampleRate {
            issues.append("Sample rate \(sampleRate) exceeds maximum for \(sampler.rawValue).")
            fixes.append("Downsample to \(sampler.maxSampleRate) Hz.")
        }

        if sampler.isMonoOnly && channels != 1 {
            issues.append("Stereo audio is not supported by \(sampler.rawValue).")
            fixes.append("Convert to mono.")
        }

        return FileValidationResult(isCompatible: issues.isEmpty, issues: issues, suggestedFixes: fixes)
    }
}
