//
//  SampleRateView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct SampleRateView: View {
    @Binding var sampleRate: Double
    var maxSampleRate: UInt32

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Sample Rate")
                .font(.headline)

            Slider(value: $sampleRate, in: 8000...Double(maxSampleRate), step: 100)
                .accentColor(.blue)

            HStack {
                Spacer()
                Text(String(format: "%.0f Hz", sampleRate))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 6)
        .help("Controls the target sample rate. Samplers have max rates; e.g., S900 supports ~37500 Hz.")
    }
}

