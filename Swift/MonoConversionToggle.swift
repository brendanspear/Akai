//
//  MonoConversionToggle.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct MonoConversionToggle: View {
    @Binding var convertToMono: Bool
    var isMonoRequired: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle(isOn: $convertToMono) {
                Text("Convert to mono")
            }
            .help("If enabled, stereo files will be downmixed to mono.")
            .disabled(isMonoRequired)
        }
        .padding(.vertical, 6)
    }
}

