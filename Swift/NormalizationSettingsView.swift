//
//  NormalizationSettingsView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct NormalizationSettingsView: View {
    @Binding var enableNormalization: Bool
    @Binding var normalizationPreview: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle("Normalize volume", isOn: $enableNormalization)
                .help("Automatically adjust gain to maximize sample loudness without clipping.")

            if enableNormalization {
                Toggle("Preview normalized audio", isOn: $normalizationPreview)
                    .help("Play audio preview before and after normalization.")
            }
        }
        .padding(.vertical, 6)
    }
}

