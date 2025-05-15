//
//  SamplerSettingsView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import SwiftUI

struct SamplerSettingsView: View {
    @Binding var selectedSampler: AkaiSampler
    @Binding var forceMono: Bool
    @Binding var targetSampleRate: UInt32
    @Binding var targetBitDepth: UInt8

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Sampler Type")
                .font(.headline)
            Picker("Sampler", selection: $selectedSampler) {
                ForEach(AkaiSampler.allCases, id: \.self) { sampler in
                    Text(sampler.rawValue).tag(sampler)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            Toggle("Force Mono Output", isOn: $forceMono)

            HStack {
                Text("Sample Rate:")
                Spacer()
                Text("\(targetSampleRate) Hz")
            }

            HStack {
                Text("Bit Depth:")
                Spacer()
                Text("\(targetBitDepth)-bit")
            }
        }
        .padding()
    }
}
