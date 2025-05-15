//
//  PaddingSilenceSettingsView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct PaddingSilenceSettingsView: View {
    @Binding var addSilence: Bool
    @Binding var silenceDurationMs: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle("Add silence to end of sample", isOn: $addSilence)
                .help("Useful for MIDI-triggered samples or preventing abrupt cutoff.")

            if addSilence {
                HStack {
                    Text("Silence Duration:")
                    Slider(value: $silenceDurationMs, in: 10...500, step: 10) {
                        Text("Silence Duration")
                    }
                    Text("\(Int(silenceDurationMs)) ms")
                        .frame(width: 60, alignment: .leading)
                }
            }
        }
        .padding(.vertical, 6)
    }
}

