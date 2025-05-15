//
//  PreviewPlayback.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI
import AVFoundation

struct PreviewPlayback: View {
    let fileURL: URL
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Preview")
                    .font(.headline)
                Spacer()
                Button(action: togglePlayback) {
                    Image(systemName: isPlaying ? "stop.fill" : "play.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(6)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                }
                .buttonStyle(BorderlessButtonStyle())
                .help("Play or stop preview of the output WAV file")
            }
        }
        .onDisappear {
            audioPlayer?.stop()
            isPlaying = false
        }
    }

    private func togglePlayback() {
        if isPlaying {
            audioPlayer?.stop()
            isPlaying = false
        } else {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                isPlaying = true
            } catch {
                print("Playback error: \(error)")
            }
        }
    }
}

