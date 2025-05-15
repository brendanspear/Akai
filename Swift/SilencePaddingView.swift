//
//  SilencePaddingView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct SilencePaddingView: View {
    @Binding var trimSilence: Bool
    @Binding var addSilence: Bool
    @Binding var silenceDurationMs: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle("Trim silence from start/end", isOn: $trimSilence)
                .help("Removes leading and trailing silence in the audio file.")

            Toggle("Add silence at end", isOn: $addSilence)
                .help("Appends silence to the end of the audio file to avoid cutoff.")

            if addSilence {
                HStack {
                    Text("Duration:")
                    Slider(value: Binding(
                        get: { Double(silenceDurationMs) },
                        set: { silenceDurationMs = Int($0) }
                    ), in: 10...1000, step: 10)
                    .frame(maxWidth: 200)

                    Text("\(silenceDurationMs) ms")
                }
            }
        }
        .padding(.vertical, 6)
    }
}

