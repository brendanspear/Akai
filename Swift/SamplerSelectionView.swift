//
//  SamplerSelectionView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct SamplerSelectionView: View {
    @Binding var selectedSampler: AkaiSampler

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Target Sampler:")
                .font(.headline)
            HStack {
                ForEach(AkaiSampler.allCases, id: \.self) { sampler in
                    Button(action: {
                        selectedSampler = sampler
                    }) {
                        Text(sampler.rawValue)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(selectedSampler == sampler ? Color.blue.opacity(0.7) : Color.gray.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .help("Select this sampler for compatibility")
                }
            }
        }
        .padding(.vertical, 4)
    }
}

