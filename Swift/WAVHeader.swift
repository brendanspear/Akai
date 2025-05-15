//
//  WAVHeader.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//

import Foundation

struct WAVHeader {
    var sampleRate: UInt32
    var bitDepth: UInt16
    var channels: UInt16
    var dataOffset: UInt32 = 44  // Standard header size

    func toData() -> Data {
        var data = Data()

        // RIFF chunk descriptor
        data.append("RIFF".data(using: .ascii)!)
        let totalSize = UInt32(dataOffset + 0) - 8  // Placeholder, to be updated later
        data.append(totalSize.littleEndianData)

        data.append("WAVE".data(using: .ascii)!)

        // fmt subchunk
        data.append("fmt ".data(using: .ascii)!)
        data.append(UInt32(16).littleEndianData)  // Subchunk1Size for PCM
        data.append(UInt16(1).littleEndianData)   // AudioFormat = 1 for PCM
        data.append(channels.littleEndianData)
        data.append(sampleRate.littleEndianData)
        let byteRate = sampleRate * UInt32(channels) * UInt32(bitDepth) / 8
        data.append(byteRate.littleEndianData)
        let blockAlign = UInt16(channels * bitDepth / 8)
        data.append(blockAlign.littleEndianData)
        data.append(bitDepth.littleEndianData)

        // data subchunk header (size appended later when writing samples)
        data.append("data".data(using: .ascii)!)
        data.append(UInt32(0).littleEndianData)  // Placeholder for Subchunk2Size

        return data
    }
}

// Helper extension
private extension FixedWidthInteger {
    var littleEndianData: Data {
        var value = self.littleEndian
        return Data(bytes: &value, count: MemoryLayout<Self>.size)
    }
}
