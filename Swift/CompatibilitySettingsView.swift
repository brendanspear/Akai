//
//  CompatibilitySettingsView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct CompatibilitySettingsView: View {
    @Binding var enforceSampleRate: Bool
    @Binding var enforceBitDepth: Bool
    @Binding var targetSampleRate: UInt32
    @Binding var targetBitDepth: UInt8
    var availableSampleRates: [UInt32]
    var availableBitDepths: [UInt8]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Compatibility Enforcement")
                .font(.headline)

            Toggle("Force sample rate", isOn: $enforceSampleRate)
            if enforceSampleRate {
                Picker("Sample rate", selection: $targetSampleRate) {
                    ForEach(availableSampleRates, id: \.self) { rate in
                        Text("\(rate) Hz").tag(rate)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .help("Ensure all files are resampled to this rate.")
            }

            Toggle("Force bit depth", isOn: $enforceBitDepth)
            if enforceBitDepth {
                Picker("Bit depth", selection: $targetBitDepth) {
                    ForEach(availableBitDepths, id: \.self) { bit in
                        Text("\(bit)-bit").tag(bit)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .help("Ensure all files use this bit depth (e.g., 12-bit for S900, 16-bit for S1000/S3000).")
            }
        }
        .padding(.vertical, 6)
    }
}

