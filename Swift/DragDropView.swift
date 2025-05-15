//
//  DragDropView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI
import UniformTypeIdentifiers

struct DragDropView: View {
    @Binding var droppedFiles: [URL]
    @State private var isHovering = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(isHovering ? Color.accentColor : Color.gray.opacity(0.4), lineWidth: 2)
                .background(Color.gray.opacity(0.05))
                .cornerRadius(10)
                .frame(maxWidth: .infinity, maxHeight: 120)
                .overlay(
                    Text("Drag & Drop Files or Folders Here")
                        .font(.headline)
                        .foregroundColor(.secondary)
                )
        }
        .padding()
        .onDrop(of: [.fileURL], isTargeted: $isHovering) { providers in
            providers.forEach { provider in
                _ = provider.loadObject(ofClass: URL.self) { url, error in
                    if let fileURL = url {
                        DispatchQueue.main.async {
                            droppedFiles.append(fileURL)
                        }
                    }
                }
            }
            return true
        }
    }
}
