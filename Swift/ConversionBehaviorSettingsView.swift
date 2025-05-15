//
//  ConversionBehaviorSettingsView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct ConversionBehaviorSettingsView: View {
    @Binding var normalizeAudio: Bool
    @Binding var trimSilence: Bool
    @Binding var addSilence: Bool
    @Binding var silenceDuration: Double  // in milliseconds

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Conversion Behavior")
                .font(.headline)

            Toggle("Normalize audio", isOn: $normalizeAudio)
                .help("Boosts the volume to maximum without clipping.")

            Toggle("Trim silence from ends", isOn: $trimSilence)
                .help("Removes leading and trailing silence automatically.")

            Toggle("Add silence to end", isOn: $addSilence)
                .help("Appends a short silent buffer after each sample for better MIDI triggering.")

            if addSilence {
                HStack {
                    Text("Silence duration:")
                    Slider(value: $silenceDuration, in: 0...1000, step: 10)
                    Text("\(Int(silenceDuration)) ms")
                        .frame(width: 60, alignment: .leading)
                }
                .help("Controls how much silence (in milliseconds) to add at the end of each sample.")
            }
        }
        .padding(.vertical, 6)
    }
}

