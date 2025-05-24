//  SamplerSettingsView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-23.
//

import SwiftUI

struct SamplerSettingsView: View {
    @ObservedObject var viewModel: SamplerSettingsViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Picker("Sampler", selection: $viewModel.settings.sampler) {
                Text("S900").tag(SamplerType.s900)
                Text("S950").tag(SamplerType.s950)
                Text("S1000/S1100").tag(SamplerType.s1000)
                Text("S3000/S3200").tag(SamplerType.s3000)
            }
            .pickerStyle(MenuPickerStyle())

            HStack(spacing: 24) {
                Toggle(isOn: $viewModel.settings.trimSilence) {
                    Text("Trim Silence")
                }
                .toggleStyle(SwitchToggleStyle())

                HStack(spacing: 12) {
                    Toggle(isOn: $viewModel.settings.addSilence) {
                        Text("Pad Silence")
                    }
                    .toggleStyle(SwitchToggleStyle())

                    Text("Duration (ms):")
                    TextField("0", value: $viewModel.settings.silenceDuration, formatter: NumberFormatter())
                        .frame(width: 60)
                }

                Toggle(isOn: $viewModel.settings.normalize) {
                    Text("Normalize Volume")
                }
                .toggleStyle(SwitchToggleStyle())

                Toggle(isOn: $viewModel.settings.convertToMono) {
                    Text("Convert to Mono")
                }
                .toggleStyle(SwitchToggleStyle())
            }
        }
        .padding()
        .background(Color(NSColor.windowBackgroundColor))
        .cornerRadius(8)
    }
}
