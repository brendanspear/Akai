//
//  FileDropZone.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import SwiftUI
import UniformTypeIdentifiers

struct FileDropZone: View {
    @Binding var droppedFiles: [URL]

    var body: some View {
        VStack {
            Text("Drag & Drop Files or Folders Here")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray.opacity(0.4), style: StrokeStyle(lineWidth: 2, dash: [5])))
        .onDrop(of: [.fileURL], isTargeted: nil) { providers in
            handleDrop(providers: providers)
        }
        .padding()
    }

    private func handleDrop(providers: [NSItemProvider]) -> Bool {
        for provider in providers {
            if provider.hasItemConformingToTypeIdentifier(UTType.fileURL.identifier) {
                provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { (item, error) in
                    if let data = item as? Data,
                       let url = URL(dataRepresentation: data, relativeTo: nil) {
                        DispatchQueue.main.async {
                            self.droppedFiles.append(url)
                        }
                    }
                }
            }
        }
        return true
    }
}

