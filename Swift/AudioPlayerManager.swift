//
//  AudioPlayerManager.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-23.
//

import Foundation
import AVFoundation

class AudioPlayerManager: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    private var currentURL: URL?

    func togglePlayback(for url: URL) async {
        if currentURL == url, let player = audioPlayer, player.isPlaying {
            player.stop()
            audioPlayer = nil
            currentURL = nil
        } else {
            await play(url: url)
        }
    }

    private func play(url: URL) async {
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            DispatchQueue.main.async {
                self.audioPlayer = player
                self.currentURL = url
                self.audioPlayer?.play()
            }
        } catch {
            print("Playback failed: \(error.localizedDescription)")
        }
    }

    /// Stops playback if the given URL is currently playing
    func stopPlayback(for url: URL) async {
        DispatchQueue.main.async {
            if self.currentURL == url {
                self.audioPlayer?.stop()
                self.audioPlayer = nil
                self.currentURL = nil
            }
        }
    }
}
