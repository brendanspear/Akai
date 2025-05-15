//
//  PreviewUtils.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//  Licensed under GNU General Public License v3.0
//

import Foundation

struct PreviewUtils {
    static func savePreview(toPath path: String, samples: [Int16], sampleRate: UInt32, bitDepth: UInt16 = 16, channels: UInt16 = 1) {
        let url = URL(fileURLWithPath: path)

        _ = WavWriter.writeWav(
            samples: samples,
            sampleRate: sampleRate,
            bitDepth: bitDepth,
            channels: channels,
            to: url
        )
    }

    // Uncomment and implement AudioFormat if needed
    /*
    static func bitDepthFromFormat(_ format: AudioFormat) -> UInt16 {
        return UInt16(format.bitDepth)
    }
    */
}
