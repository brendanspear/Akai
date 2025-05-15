//
//  DragDropController.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation
import UniformTypeIdentifiers

class DragDropController: ObservableObject {
    @Published var droppedFiles: [URL] = []

    func handleDrop(_ urls: [URL]) {
        var collectedFiles: [URL] = []

        for url in urls {
            if url.hasDirectoryPath {
                if let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: nil) {
                    for case let fileURL as URL in enumerator {
                        if fileURL.isFileURL && fileURL.pathExtension.lowercased() == "wav" {
                            collectedFiles.append(fileURL)
                        }
                    }
                }
            } else {
                if url.pathExtension.lowercased() == "wav" {
                    collectedFiles.append(url)
                }
            }
        }

        DispatchQueue.main.async {
            self.droppedFiles.append(contentsOf: collectedFiles)
        }
    }

    func clearFiles() {
        droppedFiles.removeAll()
    }
}

