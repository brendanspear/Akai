//
//  SamplerSettingsView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-XX.
//

import SwiftUI

struct SamplerSettingsView: View {
    @ObservedObject var viewModel: SamplerSettingsViewModel

    var body: some View {
        Form {
            Section(header: Text("Select Sampler")) {
                Picker("Sampler", selection: $viewModel.sampler) {
                    ForEach(SamplerType.allCases, id: \.self) { sampler in
                        Text(sampler.rawValue.capitalized).tag(sampler)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}
