//
//  WaveformView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//

import SwiftUI
import AVFoundation
import UniformTypeIdentifiers

struct WaveformView: View {
    let url: URL
    @State private var samples: [Float] = []
    @State private var isPlaying = false
    @State private var isHovering = false
    private let player = SoundPreviewPlayer()

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                ZStack(alignment: .topTrailing) {
                    Canvas { context, size in
                        guard !samples.isEmpty else { return }
                        let middle = size.height / 2
                        let scale = size.height / 2
                        let strideSize = max(1, samples.count / Int(size.width))

                        var path = Path()
                        for x in stride(from: 0, to: samples.count, by: strideSize) {
                            let sample = samples[x]
                            let y = CGFloat(sample) * scale
                            let posX = CGFloat(x) / CGFloat(strideSize)
                            path.move(to: CGPoint(x: posX, y: middle - y))
                            path.addLine(to: CGPoint(x: posX, y: middle + y))
                        }

                        context.stroke(path, with: .color(isPlaying ? .blue : .black), lineWidth: 1)
                    }
                    .frame(height: 60)
                    .onTapGesture {
                        player.playPreview(for: url)
                        isPlaying.toggle()
                    }
                    .onAppear {
                        loadWaveform(from: url)
                    }
                    .onHover { hovering in
                        isHovering = hovering
                    }
                }

                Text(url.lastPathComponent)
                    .font(.caption)
                    .lineLimit(1)
                    .padding(.leading, 8)
                    .frame(maxWidth: 150, alignment: .leading)
            }
            .padding(.vertical, 4)
        }
    }
}

extension WaveformView {
    private func loadWaveform(from url: URL) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let fallbackFile = try? AVAudioFile(forReading: url),
               let buffer = AVAudioPCMBuffer(pcmFormat: fallbackFile.processingFormat, frameCapacity: AVAudioFrameCount(fallbackFile.length)) {
                try? fallbackFile.read(into: buffer)
                if let channelData = buffer.floatChannelData?[0] {
                    let frameLength = Int(buffer.frameLength)
                    let floatArray = Array(UnsafeBufferPointer(start: channelData, count: frameLength))
                    let maxAmp = floatArray.map(abs).max() ?? 1
                    let normalizedSamples = floatArray.map { $0 / maxAmp }
                    DispatchQueue.main.async {
                        self.samples = normalizedSamples
                    }
                }
            }
        }
    }
}
