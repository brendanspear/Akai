//
//  WavPlayer.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation
import AVFoundation

class WavPlayer: NSObject, ObservableObject {
    private var audioPlayer: AVAudioPlayer?

    @Published var isPlaying: Bool = false

    func loadAndPlay(from url: URL) {
        stop()

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print("Failed to play WAV: \(error.localizedDescription)")
        }
    }

    func stop() {
        if isPlaying {
            audioPlayer?.stop()
            isPlaying = false
        }
    }
}

extension WavPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
    }
}

