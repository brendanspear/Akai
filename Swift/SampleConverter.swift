//
//  SampleConverter.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-18.
//

import Foundation
import AVFoundation

// Bridged C function from akai_bridge.h
@_silgen_name("akai_convert_file")
func akai_convert_file(
    _ inputPath: UnsafePointer<CChar>,
    _ outputDir: UnsafePointer<CChar>,
    _ model: UnsafePointer<CChar>,
    _ normalize: Bool,
    _ trim: Bool
) -> Bool

struct SampleConverter {
    static func convert(inputURL: URL, settings: ConversionSettings) -> Bool {
        print("🔁 Converting \(inputURL.lastPathComponent) using Akai model: \(settings.sampler.rawValue)")

        // Determine output directory
        guard let outputURL = settings.outputFolderURL else {
            print("❌ Output folder not set")
            return false
        }

        // Convert Swift strings to C-style strings
        guard let inputCString = inputURL.path.cString(using: .utf8),
              let outputCString = outputURL.path.cString(using: .utf8),
              let modelCString = settings.sampler.rawValue.cString(using: .utf8) else {
            print("❌ Failed to convert paths or model name to C strings")
            return false
        }

        // Call C function
        let success = akai_convert_file(
            inputCString,
            outputCString,
            modelCString,
            settings.normalize,
            settings.trimSilence
        )

        if success {
            print("✅ Akai export complete: \(inputURL.lastPathComponent)")
        } else {
            print("❌ Akai export failed for: \(inputURL.lastPathComponent)")
        }

        return success
    }
}
