//
//  SilenceSettingsView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct SilenceSettingsView: View {
    @Binding var trimSilence: Bool
    @Binding var addSilence: Bool
    @Binding var silenceDuration: Double  // in milliseconds

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle("Trim silence from start/end", isOn: $trimSilence)
                .help("Automatically remove leading and trailing silence from the audio.")

            Toggle("Add silence to end", isOn: $addSilence)
                .help("Append silence to the end of the sample (useful for looping or MIDI-triggered playback).")

            if addSilence {
                HStack {
                    Text("Silence duration:")
                    Slider(value: $silenceDuration, in: 0...1000, step: 10) {
                        Text("Silence Duration")
                    }
                    .frame(maxWidth: 200)

                    Text("\(Int(silenceDuration)) ms")
                }
            }
        }
        .padding(.vertical, 6)
    }
}

