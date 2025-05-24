//
//  DropZoneView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-19.
//

import SwiftUI
import UniformTypeIdentifiers

struct DropZoneView: View {
    var onDrop: ([URL]) -> Void

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
            .background(Color.gray.opacity(0.05))
            .overlay(
                Text("Drop files or click to select")
                    .foregroundColor(.gray)
            )
            .frame(height: 100)
            .onTapGesture {
                let panel = NSOpenPanel()
                panel.canChooseDirectories = true
                panel.canChooseFiles = true
                panel.allowsMultipleSelection = true
                if panel.runModal() == .OK {
                    onDrop(panel.urls)
                }
            }
            .onDrop(of: [.fileURL], isTargeted: nil) { providers in
                for provider in providers {
                    if provider.hasItemConformingToTypeIdentifier(UTType.fileURL.identifier) {
                        provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { item, _ in
                            if let data = item as? Data,
                               let url = NSURL(absoluteURLWithDataRepresentation: data, relativeTo: nil) as URL? {
                                DispatchQueue.main.async {
                                    onDrop([url])
                                }
                            }
                        }
                    }
                }
                return true
            }
    }
}
