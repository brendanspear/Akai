//
//  WavVisualizer..swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI
import AVFoundation

struct WavVisualizer: View {
    var samples: [Float]

    var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                let midY = size.height / 2
                let widthPerSample = size.width / CGFloat(samples.count)

                var path = Path()
                for (index, sample) in samples.enumerated() {
                    let x = CGFloat(index) * widthPerSample
                    let y = midY - CGFloat(sample) * midY
                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }

                context.stroke(path, with: .color(.blue), lineWidth: 1)
            }
        }
    }
}

struct WavVisualizer_Previews: PreviewProvider {
    static var previews: some View {
        let dummySamples: [Float] = (0..<500).map { i in
            let value = sin(Double(i) * 0.05)
            return Float(value)
        }
        WavVisualizer(samples: dummySamples)
            .frame(height: 100)
    }
}

