//
//  WaveformAnalyzer.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import Foundation
import AVFoundation

class WaveformAnalyzer {
    static func extractSamples(from url: URL, sampleCount: Int = 500) -> [Float] {
        let asset = AVURLAsset(url: url)
        guard let track = asset.tracks(withMediaType: .audio).first else {
            print("Failed to load audio track")
            return []
        }

        let readerSettings: [String: Any] = [
            AVFormatIDKey: kAudioFormatLinearPCM,
            AVLinearPCMIsBigEndianKey: false,
            AVLinearPCMIsFloatKey: false,
            AVLinearPCMBitDepthKey: 16
        ]

        do {
            let reader = try AVAssetReader(asset: asset)
            let output = AVAssetReaderTrackOutput(track: track, outputSettings: readerSettings)
            reader.add(output)
            reader.startReading()

            var sampleData = [Float]()

            while let buffer = output.copyNextSampleBuffer(), CMSampleBufferIsValid(buffer),
                  let blockBuffer = CMSampleBufferGetDataBuffer(buffer) {
                let length = CMBlockBufferGetDataLength(blockBuffer)
                var data = Data(count: length)
                data.withUnsafeMutableBytes { ptr in
                    _ = CMBlockBufferCopyDataBytes(blockBuffer, atOffset: 0, dataLength: length, destination: ptr.baseAddress!)
                }

                let count = length / MemoryLayout<Int16>.size
                data.withUnsafeBytes { ptr in
                    let samples = ptr.bindMemory(to: Int16.self)
                    for i in 0..<count {
                        sampleData.append(Float(samples[i]) / Float(Int16.max))
                    }
                }
            }

            if sampleData.isEmpty {
                return []
            }

            let strideSize = max(1, sampleData.count / sampleCount)
            let averagedSamples = stride(from: 0, to: sampleData.count, by: strideSize).map { index in
                abs(sampleData[index])
            }

            return averagedSamples
        } catch {
            print("Waveform analysis failed: \(error.localizedDescription)")
            return []
        }
    }
}
