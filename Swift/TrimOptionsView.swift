//
//  TrimOptionsView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-15.
//

import SwiftUI

struct TrimOptionsView: View {
    @Binding var trimSilence: Bool
    @Binding var addSilence: Bool
    @Binding var silenceDuration: Int

    var body: some View {
        Form {
            Toggle("Trim Silence", isOn: $trimSilence)
            Toggle("Add Silence", isOn: $addSilence)
            Stepper("Silence Duration (ms): \(silenceDuration)", value: $silenceDuration, in: 0...2000, step: 50)
        }
        .padding()
    }
}
