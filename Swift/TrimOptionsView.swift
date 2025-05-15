//
//  TrimOptionsView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct TrimOptionsView: View {
    @Binding var trimSilence: Bool
    @Binding var addSilence: Bool
    @Binding var silenceDuration: Double  // milliseconds

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Silence Options")
                .font(.headline)

            Toggle(isOn: $trimSilence) {
                Text("Trim silence from start and end")
            }
            .help("Remove silence from the beginning and end of the audio.")

            Toggle(isOn: $addSilence) {
                HStack {
                    Text("Add")
                    TextField("ms", value: $silenceDuration, formatter: NumberFormatter())
                        .frame(width: 60)
                    Text("milliseconds of silence to end")
                }
            }
            .help("Append silence to the end of each audio file.")
            .disabled(!addSilence)
        }
        .padding(.vertical, 6)
    }
}

