//
//  ProcessingOptionsView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct ProcessingOptionsView: View {
    @ObservedObject var settings: SamplerSettingsViewModel

    var body: some View {
        Section(header: Text("Processing Options").font(.headline)) {
            Toggle("Force Mono (if stereo)", isOn: $settings.forceMono)
            Toggle("Convert Sample Rate", isOn: $settings.convertSampleRate)
            
            if settings.convertSampleRate {
                HStack {
                    Text("Target Rate")
                    Spacer()
                    TextField("Hz", value: $settings.targetSampleRate, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .frame(width: 100)
                    Text("Hz")
                }
            }

            Toggle("Convert Bit Depth", isOn: $settings.convertBitDepth)

            if settings.convertBitDepth {
                Picker("Bit Depth", selection: $settings.targetBitDepth) {
                    ForEach([12, 16], id: \.self) { bit in
                        Text("\(bit)-bit").tag(bit)
                    }
                }
            }
        }
    }
}

struct ProcessingOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            ProcessingOptionsView(settings: SamplerSettingsViewModel())
        }
    }
}

