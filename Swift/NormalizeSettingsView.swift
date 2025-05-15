//
//  NormalizeSettingsView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct NormalizeSettingsView: View {
    @Binding var normalize: Bool
    @Binding var previewNormalized: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle("Normalize volume", isOn: $normalize)
                .help("Scales the audio to peak just below 0dB, ensuring consistent playback levels.")

            if normalize {
                Toggle("Preview normalized audio", isOn: $previewNormalized)
                    .help("Play a preview of the normalized version to check for clipping or loudness.")
            }
        }
        .padding(.vertical, 6)
    }
}

