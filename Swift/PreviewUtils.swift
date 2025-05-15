//
//  PreviewUtils.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import Foundation
import AVFoundation

class PreviewUtils {

    static var audioPlayer: AVAudioPlayer?

    /// Play raw PCM data as a temporary WAV file
    static func playPreview(samples: [Int16], sampleRate: UInt32, channels: Int) {
        // Create temporary WAV file
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("preview.wav")

        do {
            try WavWriter.writeWav(to: tempURL.path,
                                   samples: samples,
                                   sampleRate: sampleRate,
                                   channels: UInt8(channels))

            audioPlayer = try AVAudioPlayer(contentsOf: tempURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()

        } catch {
            print("Failed to play preview: \(error)")
        }
    }

    static func stopPreview() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}

