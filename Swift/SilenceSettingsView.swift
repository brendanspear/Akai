//
//  SilenceSettingsView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-24.
//

import SwiftUI

struct SilenceSettingsView: View {
    @Binding var settings: ConversionSettings

    var body: some View {
        HStack {
            Text("Padding Duration (sec):")
            TextField("0.25", value: $settings.silenceDuration, formatter: NumberFormatter())
                .frame(width: 60)
        }
    }
}
