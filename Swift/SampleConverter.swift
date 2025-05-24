//
//  SampleConverter.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-18.
//  Copyright © 2025 Brendan Spear. All rights reserved.
//

import Foundation
import AVFoundation

struct SampleConverter {
    static func convert(inputURL: URL, settings: ConversionSettings) -> Bool {
        // Placeholder for conversion logic using settings
        print("Converting \(inputURL.lastPathComponent) with sampler: \(settings.sampler.rawValue)")
        return true
    }

    static func extractSampleData(from asset: AVAsset) -> [Int16] {
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

                    let status = CMBlockBufferGetDataPointer(
                        blockBuffer,
                        atOffset: 0,
                        lengthAtOffsetOut: nil,
                        totalLengthOut: &length,
                        dataPointerOut: &dataPointer
                    )

                    if status == kCMBlockBufferNoErr, let dataPointer = dataPointer {
                        let sampleCount = length / MemoryLayout<Int16>.size
                        let samples = UnsafeBufferPointer(
                            start: UnsafeRawPointer(dataPointer).assumingMemoryBound(to: Int16.self),
                            count: sampleCount
                        )
                        sampleData.append(contentsOf: samples)
                    }

                    CMSampleBufferInvalidate(buffer)
                }

                if reader.status == .completed {
                    return sampleData
                } else {
                    print("Reader ended with status: \(reader.status)")
                }
            } else {
                print("Reader failed to start: \(String(describing: reader.error))")
            }
        } catch {
            print("Reader error: \(error.localizedDescription)")
        }

        return []
    }
}
