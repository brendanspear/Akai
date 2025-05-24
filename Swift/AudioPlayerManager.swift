//
//  AudioPlayerManager.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-24.
//

import Foundation
import AVFoundation

@MainActor
class AudioPlayerManager: ObservableObject {
    private var players: [URL: AVAudioPlayer] = [:]

    func togglePlayback(for url: URL) async {
        if let player = players[url], player.isPlaying {
            player.stop()
        } else {
            await play(url: url)
        }
    }

    func play(url: URL) async {
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
            players[url] = player
        } catch {
            print("❌ Failed to play \(url.lastPathComponent): \(error)")
        }
    }

    func stopPlayback(for url: URL) async {
        if let player = players[url] {
            player.stop()
            players.removeValue(forKey: url)
        }
    }
}
