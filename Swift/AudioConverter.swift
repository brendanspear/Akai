//
//  AudioConverter.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//

import Foundation
import AVFoundation

class AudioConverter {
    
    static func loadWavPCM16(from url: URL) -> (samples: [Int16], sampleRate: UInt32, channels: UInt8)? {
        guard let file = try? AVAudioFile(forReading: url),
              let format = AVAudioFormat(commonFormat: .pcmFormatInt16, sampleRate: file.fileFormat.sampleRate, channels: file.fileFormat.channelCount, interleaved: true) else {
            print("Failed to open WAV file or create format.")
            return nil
        }

        let frameCount = AVAudioFrameCount(file.length)
        guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount) else {
            print("Failed to create buffer.")
            return nil
        }

        do {
            try file.read(into: buffer)
        } catch {
            print("Error reading audio file into buffer: \(error)")
            return nil
        }

        guard let int16Data = buffer.int16ChannelData else {
            print("Expected int16 PCM data.")
            return nil
        }

        let channelCount = Int(buffer.format.channelCount)
        var samples: [Int16] = []

        // Interleaved data
        for frame in 0..<Int(buffer.frameLength) {
            for channel in 0..<channelCount {
                samples.append(int16Data[channel][frame])
            }
        }

        let sampleRate = UInt32(buffer.format.sampleRate)
        return (samples, sampleRate, UInt8(channelCount))
    }

    static func saveWavPCM16(_ samples: [Int16], sampleRate: UInt32, bitDepth: UInt8, channels: UInt8, to url: URL) -> Bool {
        let header = WAVHeader(sampleRate: sampleRate,
                               bitDepth: UInt16(bitDepth),
                               channels: UInt16(channels),
                               dataOffset: 44)

        var data = header.toData()
        for sample in samples {
            var s = sample.littleEndian
            data.append(Data(bytes: &s, count: MemoryLayout<Int16>.size))
        }

        do {
            try data.write(to: url)
            print("WAV written to \(url.path)")
            return true
        } catch {
            print("Failed to write WAV: \(error.localizedDescription)")
            return false
        }
    }
}
