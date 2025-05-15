//
//  MonoConversionSettings.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct MonoConversionSettings: View {
    @Binding var mode: MonoConversionMode

    var body: some View {
        VStack(alignment: .leading) {
            Text("Mono Conversion Mode")
                .font(.headline)
            Picker("Mono Conversion", selection: $mode) {
                ForEach(MonoConversionMode.allCases, id: \.self) { mode in
                    Text(mode.displayName)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding(.vertical)
    }
}

