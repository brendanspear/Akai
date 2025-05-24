//
//  WaveformPreviewView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-23.
//

import SwiftUI

struct WaveformPreviewView: View {
    var files: [URL]
    var statuses: [URL: FileStatus]
    var metadata: [URL: SampleMetadata]
    var removeAction: (URL) -> Void

    @StateObject private var audioPlayerManager = AudioPlayerManager()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(files), id: \.self) { url in
                    WaveformPreviewRowView(
                        url: url,
                        status: statuses[url],
                        info: metadata[url],
                        removeAction: removeAction
                    )
                    .environmentObject(audioPlayerManager)
                }
            }
            .padding(.vertical, 8)
        }
    }
}

struct WaveformPreviewRowView: View {
    var url: URL
    var status: FileStatus?
    var info: SampleMetadata?
    var removeAction: (URL) -> Void

    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    @State private var isHovering = false

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .center, spacing: 12) {
                    Text(url.lastPathComponent)
                        .font(.subheadline)
                        .lineLimit(1)
                        .truncationMode(.middle)
                        .layoutPriority(1)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if let status = status {
                        switch status {
                        case .queued:
                            Image(systemName: "clock").foregroundColor(.blue)
                        case .converting:
                            ProgressView().scaleEffect(0.6)
                        case .success:
                            Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                        case .failed:
                            Image(systemName: "xmark.octagon.fill").foregroundColor(.red)
                        }
                    }

                    if let info = info {
                        Text("• \(info.sampleRate) Hz • \(info.channels) ch • \(String(format: "%.1f", info.duration)) sec")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                ZStack(alignment: .topTrailing) {
                    WaveformView(url: url)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .clipped()

                    if isHovering {
                        Button(action: {
                            Task {
                                await audioPlayerManager.stopPlayback(for: url)
                                removeAction(url)
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                                .padding(6)
                                .transition(.opacity)
                                .opacity(isHovering ? 1 : 0)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding([.top, .trailing], 4)
                        .zIndex(10)
                    }
                }
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(6)
            .onTapGesture {
                Task {
                    await audioPlayerManager.togglePlayback(for: url)
                }
            }
            .onHover { hovering in
                withAnimation(.easeInOut(duration: 0.2)) {
                    isHovering = hovering
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
