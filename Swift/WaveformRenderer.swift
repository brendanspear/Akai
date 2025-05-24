
//  WaveformRenderer.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2024-05-XX.
//  Copyright © 2024 Brendan Spear. All rights reserved.
//

import Foundation
import AVFoundation

struct WaveformRenderer {
    static func loadWaveform(from url: URL) -> [Int16] {
        let asset = AVURLAsset(url: url)
        guard let track = asset.tracks(withMediaType: .audio).first else {
            print("No audio track found")
            return []
        }

        let readerSettings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVLinearPCMIsBigEndianKey: false,
            AVLinearPCMIsFloatKey: false,
            AVLinearPCMBitDepthKey: 16,
            AVLinearPCMIsNonInterleaved: false
        ]

        do {
            let reader = try AVAssetReader(asset: asset)
            let output = AVAssetReaderTrackOutput(track: track, outputSettings: readerSettings)

            guard reader.canAdd(output) else {
                print("Cannot add track output")
                return []
            }

            reader.add(output)
            var samples: [Int16] = []

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
                        let samplesBuffer = UnsafeBufferPointer(start: UnsafeRawPointer(dataPointer).assumingMemoryBound(to: Int16.self), count: sampleCount)
                        samples.append(contentsOf: samplesBuffer)
                    }

                    CMSampleBufferInvalidate(buffer)
                }
            }
            return samples
        } catch {
            print("Error reading waveform: \(error.localizedDescription)")
            return []
        }
    }
}
