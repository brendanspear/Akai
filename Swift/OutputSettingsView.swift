//
//  OutputSettingsView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct OutputSettingsView: View {
    @ObservedObject var settings: SamplerSettingsViewModel

    var body: some View {
        Section(header: Text("Output Settings").font(.headline)) {
            Picker("Max Output Size", selection: $settings.selectedOutputOption) {
                ForEach(SamplerOutputOption.allCases) { option in
                    Text(option.displayName).tag(option)
                }
            }

            Toggle("Normalize Audio", isOn: $settings.normalizeAudio)
            Toggle("Trim Silence", isOn: $settings.trimSilence)
            Toggle("Add Tail Silence", isOn: $settings.addTailSilence)

            if settings.addTailSilence {
                HStack {
                    Text("Tail Duration")
                    Spacer()
                    TextField("ms", value: $settings.tailSilenceDurationMs, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .frame(width: 80)
                    Text("ms")
                }
            }
        }
    }
}

struct OutputSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            OutputSettingsView(settings: SamplerSettingsViewModel())
        }
    }
}

