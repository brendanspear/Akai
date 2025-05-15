//
//  AudioWarnings.Swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

enum AudioWarning: String, CaseIterable {
    case stereoToMono = "Input file is stereo but target sampler is mono; will convert to mono."
    case highSampleRate = "Sample rate exceeds maximum supported by selected Akai sampler; will resample."
    case unsupportedBitDepth = "Input bit depth is not supported by selected Akai sampler; will convert."
    case excessiveDuration = "Sample duration is long and may exceed sampler memory limits."
    case missingData = "Could not extract audio data correctly from file."

    var isCritical: Bool {
        switch self {
        case .missingData:
            return true
        default:
            return false
        }
    }
}
