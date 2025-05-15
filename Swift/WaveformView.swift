//
//  WaveformView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import SwiftUI

struct WaveformView: View {
    var audioURL: URL

    var body: some View {
        VStack {
            Text("Waveform for \(audioURL.lastPathComponent)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(height: 100)
        .background(Color.gray.opacity(0.1))
    }
}
