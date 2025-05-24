//
//  WavWriter.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-24.
//

import Foundation
import AVFoundation

struct WavWriter {
    static func writePCM16WAV(inputURL: URL, outputURL: URL) -> Bool {
        let asset = AVAsset(url: inputURL)

        guard let track = asset.tracks(withMediaType: .audio).first else {
            print("❌ No audio track found in \(inputURL.lastPathComponent)")
            return false
        }

        let readerSettings: [String: Any] = [
            AVFormatIDKey: kAudioFormatLinearPCM,
            AVLinearPCMIsBigEndianKey: false,
            AVLinearPCMIsFloatKey: false,
            AVLinearPCMBitDepthKey: 16,
            AVLinearPCMIsNonInterleaved: false
        ]

        do {
            let reader = try AVAssetReader(asset: asset)
            let output = AVAssetReaderTrackOutput(track: track, outputSettings: readerSettings)

            guard reader.canAdd(output) else {
                print("❌ Cannot add track output to reader")
                return false
            }

            reader.add(output)

            let audioFormat = AVAudioFormat(
                commonFormat: .pcmFormatInt16,
                sampleRate: 44100,
                channels: 1,
                interleaved: true
            )

            guard let format = audioFormat else {
                print("❌ Failed to create AVAudioFormat")
                return false
            }

            let writer = try AVAudioFile(forWriting: outputURL, settings: format.settings)

            reader.startReading()
            while reader.status == .reading {
                if let sampleBuffer = output.copyNextSampleBuffer(),
                   let blockBuffer = CMSampleBufferGetDataBuffer(sampleBuffer) {

                    var length = 0
                    var dataPointer: UnsafeMutablePointer<Int8>?

                    let status = CMBlockBufferGetDataPointer(
                        blockBuffer,
                        atOffset: 0,
                        lengthAtOffsetOut: nil,
                        totalLengthOut: &length,
                        dataPointerOut: &dataPointer
                    )

                    if status == kCMBlockBufferNoErr, let pointer = dataPointer {
                        let frameLength = length / Int(format.streamDescription.pointee.mBytesPerFrame)
                        guard let pcmBuffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(frameLength)) else {
                            CMSampleBufferInvalidate(sampleBuffer)
                            continue
                        }

                        pcmBuffer.frameLength = AVAudioFrameCount(frameLength)

                        if pcmBuffer.frameLength > 0,
                           let channelData = pcmBuffer.int16ChannelData?.pointee {
                            memcpy(channelData, pointer, length)
                            do {
                                try writer.write(from: pcmBuffer)
                            } catch {
                                print("❌ Failed writing buffer to file: \(error)")
                            }
                        } else {
                            print("⚠️ Skipped writing empty or invalid buffer. Frame length: \(pcmBuffer.frameLength), length: \(length)")
                        }
                    }

                    CMSampleBufferInvalidate(sampleBuffer)
                }
            }

            if reader.status == .completed {
                print("✅ WAV export completed: \(outputURL.lastPathComponent)")
                return true
            } else {
                print("❌ WAV export failed: \(reader.status)")
                return false
            }
        } catch {
            print("❌ WAV export error: \(error)")
            return false
        }
    }
}
