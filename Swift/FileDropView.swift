// FileDropView.swift
// AkaiSConvert
//
// Created by Brendan Spear on 2025-05-18.

import SwiftUI
import UniformTypeIdentifiers

struct FileDropView: View {
    var onDrop: ([URL]) -> Void

    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .onDrop(of: [UTType.fileURL], isTargeted: nil) { providers in
                providers.first?.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { (item, error) in
                    if let data = item as? Data, let url = URL(dataRepresentation: data, relativeTo: nil) {
                        DispatchQueue.main.async {
                            onDrop([url])
                        }
                    }
                }
                return true
            }
    }
}
