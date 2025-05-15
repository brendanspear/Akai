//
//  VolumeNormalizationView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct VolumeNormalizationView: View {
    @Binding var normalizeVolume: Bool
    @Binding var normalizationLevel: Double  // 0.0 - 1.0, representing 0% to 100%

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle("Normalize volume", isOn: $normalizeVolume)
                .help("Adjusts the audio level to peak at the specified target level.")

            if normalizeVolume {
                HStack {
                    Text("Target peak:")
                    Slider(value: $normalizationLevel, in: 0.5...1.0, step: 0.01)
                        .frame(maxWidth: 200)
                    Text("\(Int(normalizationLevel * 100))%")
                }
            }
        }
        .padding(.vertical, 6)
    }
}

