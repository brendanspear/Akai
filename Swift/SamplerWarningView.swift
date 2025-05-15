//
//  SamplerWarningView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct SamplerWarningView: View {
    var warnings: [String]

    var body: some View {
        if warnings.isEmpty {
            EmptyView()
        } else {
            VStack(alignment: .leading, spacing: 8) {
                Text("⚠️ Compatibility Warnings")
                    .font(.headline)
                    .foregroundColor(.orange)

                ForEach(warnings, id: \.self) { warning in
                    Text("• \(warning)")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
            }
            .padding()
            .background(Color.yellow.opacity(0.2))
            .cornerRadius(8)
        }
    }
}

