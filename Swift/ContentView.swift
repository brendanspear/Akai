//
//  ContentView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/17/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedFileURL: URL?
    @State private var selectedSampler = "S900/950"
    @State private var convertToMono = true
    @State private var normalize = false
    @State private var trimSilence = true
    @State private var addSilence = false
    @State private var silenceDuration = 0
    @State private var autoFix = true
    @State private var outputFolderURL: URL?

    let samplers = ["S900/950", "S1000/S1100", "S3000/S3200"]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Akai Sample Converter")
                .font(.title)
                .padding(.top)

            FileDropView(fileURL: $selectedFileURL)

            Picker("Sampler", selection: $selectedSampler) {
                ForEach(samplers, id: \.self) { sampler in
                    Text(sampler)
                }
            }
            .pickerStyle(MenuPickerStyle())

            Toggle("Convert to mono", isOn: $convertToMono)
            Toggle("Normalize", isOn: $normalize)
            Toggle("Trim silence", isOn: $trimSilence)
            Toggle("Pad silence", isOn: $addSilence)

            HStack {
                Text("Silence Duration (ms):")
                TextField("0", value: $silenceDuration, formatter: NumberFormatter())
                    .frame(width: 80)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            Toggle("Auto-fix", isOn: $autoFix)

            HStack {
                Text("Output:")
                Spacer()
                Button("Choose...") {
                    let panel = NSOpenPanel()
                    panel.canChooseDirectories = true
                    panel.canChooseFiles = false
                    if panel.runModal() == .OK {
                        outputFolderURL = panel.url
                    }
                }
            }

            Button("Convert") {
                // conversion logic placeholder
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Spacer()
        }
        .padding()
        .frame(width: 400)
    }
}

#Preview {
    ContentView()
}
