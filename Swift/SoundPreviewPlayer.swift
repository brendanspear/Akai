//
//  SoundPreviewPlayer.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation
import AVFoundation

class SoundPreviewPlayer {
    private var audioPlayer: AVAudioPlayer?

    func playPreview(for url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error playing preview: \(error.localizedDescription)")
        }
    }

    func stopPreview() {
        audioPlayer?.stop()
    }

    var isPlaying: Bool {
        return audioPlayer?.isPlaying ?? false
    }
}

