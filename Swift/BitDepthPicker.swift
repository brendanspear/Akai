//
//  BitDepthPicker.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct BitDepthPicker: View {
    @Binding var selectedBitDepth: UInt8
    var supportedBitDepths: [UInt8]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Bit Depth")
                .font(.headline)

            Picker("Bit Depth", selection: $selectedBitDepth) {
                ForEach(supportedBitDepths, id: \.self) { depth in
                    Text("\(depth)-bit").tag(depth)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding(.vertical, 6)
        .help("Select the target bit depth for conversion.")
    }
}

