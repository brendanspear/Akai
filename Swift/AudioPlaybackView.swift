//
//  AudioPlaybackView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import SwiftUI
import AVFoundation

struct AudioPlaybackView: View {
    let audioURL: URL

    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying: Bool = false
    @State private var duration: TimeInterval = 0
    @State private var currentTime: TimeInterval = 0
    @State private var timer: Timer?

    var body: some View {
        VStack(spacing: 12) {
            // Placeholder waveform view (we'll wire in waveform data in a later version)
            Text("Waveform Preview")
                .frame(height: 80)
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(8)

            HStack {
                Button(action: togglePlayback) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.accentColor)
                }

                Slider(value: Binding(get: {
                    currentTime
                }, set: { newValue in
                    currentTime = newValue
                    audioPlayer?.currentTime = newValue
                }), in: 0...duration)
            }

            HStack {
                Text(formatTime(currentTime))
                Spacer()
                Text(formatTime(duration))
            }
            .font(.footnote)
            .padding(.horizontal, 8)
        }
        .padding()
        .onAppear(perform: preparePlayer)
        .onDisappear(perform: stopPlayback)
    }

    private func preparePlayer() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            duration = audioPlayer?.duration ?? 0
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error loading audio: \(error.localizedDescription)")
        }
    }

    private func togglePlayback() {
        guard let player = audioPlayer else { return }

        if isPlaying {
            player.pause()
            stopTimer()
        } else {
            player.play()
            startTimer()
        }

        isPlaying.toggle()
    }

    private func stopPlayback() {
        audioPlayer?.stop()
        stopTimer()
        isPlaying = false
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            currentTime = audioPlayer?.currentTime ?? 0
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
