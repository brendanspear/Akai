//
//  ConversionViewModel.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-24.
//

import Foundation
import SwiftUI

class ConversionViewModel: ObservableObject {
    @Published var inputFiles: [URL] = []
    @Published var fileStatuses: [URL: FileConversionStatus] = [:]
    @Published var metadata: [URL: AudioMetadata] = [:]
    @Published var settings: ConversionSettings = ConversionSettings.defaultSettings()

    func selectInputFiles() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = true
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowedFileTypes = ["wav", "aif", "aiff", "mp3"]

        if panel.runModal() == .OK {
            for file in panel.urls {
                if !inputFiles.contains(file) {
                    inputFiles.append(file)
                    fileStatuses[file] = .queued
                }
            }
        }
    }

    func selectOutputFolder() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false

        if panel.runModal() == .OK {
            settings.outputFolderURL = panel.url
        }
    }

    func promptForOutputFolderIfNeeded() -> Bool {
        if settings.outputFolderURL == nil {
            selectOutputFolder()
        }
        return settings.outputFolderURL != nil
    }

    func removeFile(_ file: URL) {
        if let index = inputFiles.firstIndex(of: file) {
            inputFiles.remove(at: index)
            fileStatuses.removeValue(forKey: file)
            metadata.removeValue(forKey: file)
        }
    }

    func resetAll() {
        inputFiles = []
        fileStatuses.removeAll()
        metadata.removeAll()
        settings = ConversionSettings.defaultSettings()
    }

    func handleDroppedItems(providers: [NSItemProvider]) {
        for provider in providers {
            if provider.hasItemConformingToTypeIdentifier("public.file-url") {
                _ = provider.loadItem(forTypeIdentifier: "public.file-url", options: nil) { item, error in
                    if let data = item as? Data,
                       let url = URL(dataRepresentation: data, relativeTo: nil) {
                        DispatchQueue.main.async {
                            if !self.inputFiles.contains(url) {
                                self.inputFiles.append(url)
                                self.fileStatuses[url] = .queued
                            }
                        }
                    }
                }
            }
        }
    }
}
