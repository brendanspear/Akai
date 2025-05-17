//
//  WaveformPreview.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//

import SwiftUI

struct WaveformPreview: View {
    let samples: [Int16]

    var body: some View {
        GeometryReader { geometry in
            let normalized = normalize(samples)
            let points = normalized.enumerated().map { index, value -> CGPoint in
                let x = CGFloat(index) / CGFloat(normalized.count) * geometry.size.width
                let y = geometry.size.height / 2 - CGFloat(value) / CGFloat(Int16.max) * geometry.size.height / 2
                return CGPoint(x: x, y: y)
            }

            Path { path in
                guard let first = points.first else { return }
                path.move(to: first)
                for point in points.dropFirst() {
                    path.addLine(to: point)
                }
            }
            .stroke(Color.accentColor, lineWidth: 1)
        }
    }

    private func normalize(_ samples: [Int16]) -> [Int16] {
        guard let maxSample = samples.map({ abs(Int($0)) }).max(), maxSample > 0 else {
            return samples
        }
        let scale = Float(Int16.max) / Float(maxSample)
        return samples.map {
            let scaled = Float($0) * scale
            let clamped = max(Float(Int16.min), min(Float(Int16.max), scaled))
            return Int16(clamped)
        }
    }
}
