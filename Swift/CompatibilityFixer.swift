//
//  CompatibilityFixer.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import Foundation
import AVFoundation

class CompatibilityFixer {
    
    static func applyFixes(to url: URL, for sampler: AkaiSampler, completion: @escaping (URL?) -> Void) {
        let asset = AVURLAsset(url: url)
        let outputURL = url.deletingPathExtension().appendingPathExtension("fixed.wav")
        
        guard let reader = try? AVAssetReader(asset: asset),
              let track = asset.tracks(withMediaType: .audio).first else {
            completion(nil)
            return
        }

        let format = AVAudioFormat(standardFormatWithSampleRate: Double(sampler.maxSampleRate), channels: sampler.isMonoOnly ? 1 : track.formatDescriptions.first.flatMap {
            let desc = $0 as! CMAudioFormatDescription
            let asbd = CMAudioFormatDescriptionGetStreamBasicDescription(desc)!
            return AVAudioChannelCount(asbd.pointee.mChannelsPerFrame)
        } ?? 2)

        let outputSettings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVLinearPCMBitDepthKey: 16,
            AVLinearPCMIsFloatKey: false,
            AVLinearPCMIsBigEndianKey: false
        ]

        let readerOutput = AVAssetReaderTrackOutput(track: track, outputSettings: outputSettings)
        reader.add(readerOutput)
        reader.startReading()

        guard let bufferFormat = format else {
            completion(nil)
            return
        }

        let engine = AVAudioEngine()
        let player = AVAudioPlayerNode()
        engine.attach(player)

        let mainMixer = engine.mainMixerNode
        engine.connect(player, to: mainMixer, format: bufferFormat)

        let outputFile: AVAudioFile
        do {
            outputFile = try AVAudioFile(forWriting: outputURL, settings: bufferFormat.settings)
        } catch {
            completion(nil)
            return
        }

        engine.prepare()
        try? engine.start()

        player.installTap(onBus: 0, bufferSize: 1024, format: bufferFormat) { buffer, _ in
            try? outputFile.write(from: buffer)
        }

        let readerQueue = DispatchQueue(label: "reader.queue")
        readerQueue.async {
            while reader.status == .reading {
                if let sampleBuffer = readerOutput.copyNextSampleBuffer(),
                   let blockBuffer = CMSampleBufferGetDataBuffer(sampleBuffer) {
                    var length = 0
                    var dataPointer: UnsafeMutablePointer<Int8>?
                    CMBlockBufferGetDataPointer(blockBuffer, atOffset: 0, lengthAtOffsetOut: nil, totalLengthOut: &length, dataPointerOut: &dataPointer)

                    if let pointer = dataPointer {
                        let audioBuffer = AVAudioPCMBuffer(pcmFormat: bufferFormat, frameCapacity: AVAudioFrameCount(length) / bufferFormat.streamDescription.pointee.mBytesPerFrame)!
                        audioBuffer.frameLength = audioBuffer.frameCapacity
                        memcpy(audioBuffer.int16ChannelData![0], pointer, length)
                        player.scheduleBuffer(audioBuffer, completionHandler: nil)
                    }
                }
            }

            DispatchQueue.main.async {
                player.removeTap(onBus: 0)
                engine.stop()
                completion(outputURL)
            }
        }

        player.play()
    }
}
