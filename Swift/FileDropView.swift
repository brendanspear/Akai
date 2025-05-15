//
//  FileDropView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI
import UniformTypeIdentifiers

struct FileDropView: View {
    var onDrop: ([URL]) -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10]))
                .foregroundColor(.blue)
                .background(Color.gray.opacity(0.1))
                .frame(minHeight: 120)
            
            VStack(spacing: 8) {
                Image(systemName: "arrow.down.doc")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                Text("Drag & Drop Files or Folders Here")
                    .font(.headline)
                Text("Supports WAV, AIFF, Logic Sampler, etc.")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .onDrop(of: [UTType.fileURL], isTargeted: nil) { providers in
            Task {
                var urls: [URL] = []
                for provider in providers {
                    if let item = try? await provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier) as? URL {
                        urls.append(item)
                    }
                }
                if !urls.isEmpty {
                    onDrop(urls)
                }
            }
            return true
        }
        .padding(.horizontal)
    }
}

