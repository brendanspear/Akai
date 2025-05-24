//
//  SafeAudioLoader.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2024-05-XX.
//  Copyright © 2024 Brendan Spear. All rights reserved.
//

import Foundation
import AVFoundation

/// Loads a waveform from a file and returns an array of Int16 samples.
/// - Parameter url: The URL of the audio file.
/// - Returns: An array of 16-bit PCM audio samples, or an empty array if loading fails.
func loadAudioAssetSafely(url: URL) -> [Int16] {
    let asset = AVURLAsset(url: url)
    let readerSettings: [String: Any] = [
        AVFormatIDKey: Int(kAudioFormatLinearPCM),
        AVLinearPCMIsBigEndianKey: false,
        AVLinearPCMIsFloatKey: false,
        AVLinearPCMBitDepthKey: 16,
        AVLinearPCMIsNonInterleaved: false
    ]

    guard let track = asset.tracks(withMediaType: .audio).first else {
        print("Failed to access audio track")
        return []
    }

    do {
        let reader = try AVAssetReader(asset: asset)
        let output = AVAssetReaderTrackOutput(track: track, outputSettings: readerSettings)

        guard reader.canAdd(output) else {
            print("Cannot add track output")
            return []
        }

        reader.add(output)

        var sampleData: [Int16] = []

        if reader.startReading() {
            while reader.status == .reading {
                guard let buffer = output.copyNextSampleBuffer(),
                      let blockBuffer = CMSampleBufferGetDataBuffer(buffer) else {
                    break
                }

                var length = 0
                var dataPointer: UnsafeMutablePointer<Int8>?

                let status = CMBlockBufferGetDataPointer(blockBuffer, atOffset: 0, lengthAtOffsetOut: nil, totalLengthOut: &length, dataPointerOut: &dataPointer)

                if status == kCMBlockBufferNoErr, let dataPointer = dataPointer {
                    let sampleCount = length / MemoryLayout<Int16>.size
                    let samples = UnsafeBufferPointer(start: UnsafeRawPointer(dataPointer).assumingMemoryBound(to: Int16.self), count: sampleCount)
                    sampleData.append(contentsOf: samples)
                }

                CMSampleBufferInvalidate(buffer)
            }

            if reader.status == .completed {
                return sampleData
            } else {
                print("Reader finished with status: \(reader.status)")
            }
        } else {
            print("Reader failed to start: \(String(describing: reader.error))")
        }
    } catch {
        print("Reader error: \(error.localizedDescription)")
    }

    return []
}
