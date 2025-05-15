//
//  OutputFormatSettingsView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct OutputFormatSettingsView: View {
    @Binding var selectedBitDepth: UInt8
    @Binding var sampleRate: UInt32

    let availableBitDepths: [UInt8]
    let maxSampleRate: UInt32

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Output Format Settings")
                .font(.headline)

            Picker("Bit Depth", selection: $selectedBitDepth) {
                ForEach(availableBitDepths, id: \.self) { depth in
                    Text("\(depth)-bit").tag(depth)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .help("Choose the output bit depth supported by your sampler.")

            HStack {
                Text("Sample Rate:")
                Slider(value: Binding(get: {
                    Double(sampleRate)
                }, set: { newValue in
                    sampleRate = UInt32(newValue)
                }), in: 8000...Double(maxSampleRate), step: 1000)
                Text("\(sampleRate) Hz")
                    .frame(width: 80, alignment: .leading)
            }
            .help("Select a sample rate within the range supported by your sampler.")
        }
        .padding(.vertical, 6)
    }
}

