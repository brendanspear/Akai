//
//  OutputDiskWriter.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import Foundation

class OutputDiskWriter {

    /// Writes raw data to a file in the target directory.
    static func writeSampleData(_ data: Data,
                                to directory: URL,
                                baseName: String,
                                format: String = "akai",
                                extensionHint: String = ".out") -> URL? {
        let fileName = "\(baseName)_converted.\(format)\(extensionHint)"
        let fileURL = directory.appendingPathComponent(fileName)

        do {
            try data.write(to: fileURL)
            print("Saved: \(fileURL.path)")
            return fileURL
        } catch {
            print("Failed to write sample data: \(error.localizedDescription)")
            return nil
        }
    }

    /// Generates a file name from the original file and desired suffix.
    static func generateFilename(from originalURL: URL, suffix: String, ext: String) -> String {
        let base = originalURL.deletingPathExtension().lastPathComponent
        return "\(base)_\(suffix).\(ext)"
    }

    /// Writes a WAV file using the provided samples and metadata.
    static func writeWav(samples: [Int16],
                         sampleRate: UInt32,
                         bitDepth: UInt8,
                         channels: UInt8,
                         to outputDirectory: URL,
                         originalFilename: String) -> URL? {

        let fileName = generateFilename(from: URL(fileURLWithPath: originalFilename),
                                        suffix: "converted",
                                        ext: "wav")
        let fileURL = outputDirectory.appendingPathComponent(fileName)

        let wavHeader = WAVHeader(
            sampleRate: sampleRate,
            bitDepth: UInt16(bitDepth),
            channels: UInt16(channels),
            dataOffset: 44
        )

        let result = WavWriter.writeWav(
            samples: samples,
            sampleRate: sampleRate,
            bitDepth: UInt16(bitDepth),
            channels: UInt16(channels),
            to: fileURL
        )
        

        if result {
            print("WAV file saved: \(fileURL.path)")
            return fileURL
        } else {
            print("Failed to save WAV file.")
            return nil
        }
    }
}
