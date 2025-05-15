//
//  SamplePreviewPlayer.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import Foundation
import AVFoundation

class SamplePreviewPlayer: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    @Published var isPlaying: Bool = false

    func playSample(from url: URL) {
        stop()

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print("Failed to play sample: \(error.localizedDescription)")
            isPlaying = false
        }
    }

    func stop() {
        audioPlayer?.stop()
        isPlaying = false
    }
}
