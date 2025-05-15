//
//  FormatChecker.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import Foundation
import AVFoundation


struct FormatCheckResult {
    let isCompatible: Bool
    let issues: [String]
    let suggestedFixes: [String]
}

enum AkaiModel {
    case s900
    case s1000
    case s3000
}

class FormatChecker {
    
    static func checkCompatibility(for fileURL: URL, targetModel: AkaiModel) -> FormatCheckResult {
        var issues = [String]()
        var fixes = [String]()

        let asset = AVURLAsset(url: fileURL)
        guard let format = asset.tracks(withMediaType: .audio).first?.formatDescriptions.first as? CMAudioFormatDescription,
              let asbd = CMAudioFormatDescriptionGetStreamBasicDescription(format)?.pointee else {
            return FormatCheckResult(isCompatible: false, issues: ["Unable to read audio format"], suggestedFixes: [])
        }

        let sampleRate = Int(asbd.mSampleRate)
        let channels = Int(asbd.mChannelsPerFrame)
        let bitDepth = Int(asbd.mBitsPerChannel)

        // Define compatibility rules
        switch targetModel {
        case .s900:
            if sampleRate > 40000 {
                issues.append("Sample rate exceeds 40kHz")
                fixes.append("Resample to 40kHz or below")
            }
            if bitDepth != 12 {
                issues.append("Expected 12-bit audio for S900")
                fixes.append("Convert to 12-bit format")
            }
            if channels > 1 {
                issues.append("S900 only supports mono")
                fixes.append("Convert to mono")
            }
        case .s1000, .s3000:
            if sampleRate > 48000 {
                issues.append("Sample rate exceeds 48kHz")
                fixes.append("Resample to 48kHz or below")
            }
            if bitDepth != 16 {
                issues.append("Expected 16-bit audio")
                fixes.append("Convert to 16-bit format")
            }
        }

        let compatible = issues.isEmpty
        return FormatCheckResult(isCompatible: compatible, issues: issues, suggestedFixes: fixes)
    }
}

