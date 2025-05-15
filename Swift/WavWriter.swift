//
//  WavWriter.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import Foundation

class WavWriter {

    /// Writes a PCM16 WAV file to disk with a proper WAV header.
    /// - Parameters:
    ///   - samples: Audio samples in 16-bit PCM format.
    ///   - sampleRate: Sample rate (e.g. 44100 Hz).
    ///   - bitDepth: Bit depth (should be 16).
    ///   - channels: Number of audio channels (1 for mono, 2 for stereo).
    ///   - outputURL: Destination file path.
    /// - Returns: `true` if write succeeds, `false` otherwise.
    static func writeWav(samples: [Int16],
                         sampleRate: UInt32,
                         bitDepth: UInt16,
                         channels: UInt16,
                         to outputURL: URL) -> Bool {

        guard bitDepth == 16 else {
            print("Unsupported bit depth: \(bitDepth)")
            return false
        }

        let byteRate = sampleRate * UInt32(channels) * UInt32(bitDepth / 8)
        let blockAlign = UInt16(channels * (bitDepth / 8))
        let dataSize = UInt32(samples.count * MemoryLayout<Int16>.size)
        let chunkSize = 36 + dataSize

        var wavData = Data()

        // RIFF Header
        wavData.append(contentsOf: "RIFF".utf8)
        wavData.append(UInt32(chunkSize).littleEndianData)
        wavData.append(contentsOf: "WAVE".utf8)

        // fmt subchunk
        wavData.append(contentsOf: "fmt ".utf8)
        wavData.append(UInt32(16).littleEndianData)                  // Subchunk1Size
        wavData.append(UInt16(1).littleEndianData)                   // AudioFormat (1 = PCM)
        wavData.append(UInt16(channels).littleEndianData)           // NumChannels
        wavData.append(UInt32(sampleRate).littleEndianData)         // SampleRate
        wavData.append(UInt32(byteRate).littleEndianData)           // ByteRate
        wavData.append(UInt16(blockAlign).littleEndianData)         // BlockAlign
        wavData.append(UInt16(bitDepth).littleEndianData)           // BitsPerSample

        // data subchunk
        wavData.append(contentsOf: "data".utf8)
        wavData.append(UInt32(dataSize).littleEndianData)

        // Append sample data
        let sampleData = samples.withUnsafeBufferPointer {
            Data(buffer: $0)
        }
        wavData.append(sampleData)

        do {
            try wavData.write(to: outputURL)
            return true
        } catch {
            print("Failed to write WAV file: \(error)")
            return false
        }
    }
}

private extension FixedWidthInteger {
    var littleEndianData: Data {
        withUnsafeBytes(of: self.littleEndian) { Data($0) }
    }
}
