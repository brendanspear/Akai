//  WaveformLoader.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-23.

import Foundation
import AVFoundation

@MainActor
class WaveformLoader: ObservableObject {
    @Published var samples: [Float] = []

    func load(from url: URL) {
        Task.detached(priority: .userInitiated) { [weak self] in
            let newSamples = await Self.loadWaveformSamplesAsync(from: url)

            if let self = self {
                await MainActor.run {
                    self.samples = newSamples
                }
            }
        }
    }

    static func loadWaveformSamplesAsync(from url: URL) async -> [Float] {
        let asset = AVAsset(url: url)
        guard let track = asset.tracks(withMediaType: .audio).first else {
            print("❌ No audio track found in file: \(url.lastPathComponent)")
            return []
        }

        do {
            let reader = try AVAssetReader(asset: asset)
            let outputSettings: [String: Any] = [AVFormatIDKey: kAudioFormatLinearPCM]
            let output = AVAssetReaderTrackOutput(track: track, outputSettings: outputSettings)

            guard reader.canAdd(output) else {
                print("❌ Cannot add output")
                return []
            }

            reader.add(output)

            if !reader.startReading() {
                print("❌ AVAssetReader failed to start. Status: \(reader.status)")
                if let error = reader.error {
                    print("Error: \(error.localizedDescription)")
                }
                return []
            }

            var rawSamples: [Float] = []
            while let buffer = output.copyNextSampleBuffer(),
                  let blockBuffer = CMSampleBufferGetDataBuffer(buffer) {
                let length = CMBlockBufferGetDataLength(blockBuffer)
                var data = [Int16](repeating: 0, count: length / MemoryLayout<Int16>.size)
                CMBlockBufferCopyDataBytes(blockBuffer, atOffset: 0, dataLength: length, destination: &data)

                rawSamples.append(contentsOf: data.map { Float($0) / Float(Int16.max) })
            }

            return downsample(samples: rawSamples, to: 300)
        } catch {
            print("❌ Failed to read audio samples: \(error)")
            return []
        }
    }

    static func downsample(samples: [Float], to targetCount: Int) -> [Float] {
        guard samples.count > targetCount else { return samples }
        let step = samples.count / targetCount
        return stride(from: 0, to: samples.count, by: step).map { abs(samples[$0]) }
    }
}
