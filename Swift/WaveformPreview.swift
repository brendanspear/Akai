//
//  WaveformPreview.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI

struct WaveformPreview: View {
    let samples: [Int16]
    let color: Color
    let height: CGFloat

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let totalSamples = samples.count
            let strideCount = Int(width)
            let samplesPerStride = max(1, totalSamples / strideCount)
            let normalizedSamples = normalize(samples)
            let downsampled = stride(from: 0, to: totalSamples, by: samplesPerStride).map {
                normalizedSamples[$0]
            }

            Path { path in
                for (x, sample) in downsampled.enumerated() {
                    let xPos = CGFloat(x)
                    let yCenter = height / 2
                    let yValue = CGFloat(sample) * (height / 2) / CGFloat(Int16.max)
                    path.move(to: CGPoint(x: xPos, y: yCenter - yValue))
                    path.addLine(to: CGPoint(x: xPos, y: yCenter + yValue))
                }
            }
            .stroke(color, lineWidth: 1)
        }
        .frame(height: height)
    }

    private func normalize(_ samples: [Int16]) -> [Int16] {
        guard let max = samples.map({ abs(Int($0)) }).max(), max > 0 else {
            return samples
        }
        let scale = Float(Int16.max) / Float(max)
        return samples.map { Int16(clamping: Float($0) * scale) }
    }
}
