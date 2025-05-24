//  ConversionViewModel.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-23.
//

import Foundation
import AVFoundation
import UniformTypeIdentifiers
import AppKit

class ConversionViewModel: ObservableObject {
    @Published var inputFiles: [URL] = []
    @Published var fileStatuses: [URL: FileStatus] = [:]
    @Published var metadata: [URL: SampleMetadata] = [:]
    @Published var settings: ConversionSettings

    init() {
        self.settings = ConversionSettings(
            sampler: .s1000,
            trimSilence: false,
            addSilence: false,
            silenceDuration: 0,
            normalizeVolume: false,
            convertToMono: false,
            sampleRate: 44100,
            bitDepth: 16,
            format: SampleFormat.pcm16,
            outputFolderURL: nil
        )
    }

    func selectInputFiles() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = true
        panel.canChooseDirectories = true
        panel.canChooseFiles = true
        panel.allowedContentTypes = [UTType.audio]

        if panel.runModal() == .OK {
            handleSelectedFiles(panel.urls)
        }
    }

    func selectOutputFolder() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false

        if panel.runModal() == .OK {
            DispatchQueue.main.async {
                self.settings.outputFolderURL = panel.url
            }
        }
    }

    func handleDroppedItems(providers: [NSItemProvider]) {
        for provider in providers {
            provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { item, _ in
                if let data = item as? Data,
                   let url = NSURL(absoluteURLWithDataRepresentation: data, relativeTo: nil) as URL? {
                    DispatchQueue.main.async {
                        self.handleSelectedFiles([url])
                    }
                }
            }
        }
    }

    func handleSelectedFiles(_ urls: [URL]) {
        let newFiles = urls.filter { !self.inputFiles.contains($0) }
        guard !newFiles.isEmpty else { return }

        DispatchQueue.global(qos: .userInitiated).async {
            var fileMeta: [URL: SampleMetadata] = [:]
            for url in newFiles {
                let asset = AVURLAsset(url: url)
                let duration = CMTimeGetSeconds(asset.duration)

                if let formatDescAny = asset.tracks(withMediaType: .audio).first?.formatDescriptions.first,
                   let asbd = CMAudioFormatDescriptionGetStreamBasicDescription(formatDescAny as! CMAudioFormatDescription) {
                    let sampleRate = asbd.pointee.mSampleRate
                    let channels = Int(asbd.pointee.mChannelsPerFrame)
                    let metadata = SampleMetadata(sampleRate: sampleRate, channels: channels, duration: duration)
                    fileMeta[url] = metadata
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.inputFiles.append(contentsOf: newFiles)
                for url in newFiles {
                    self.fileStatuses[url] = .queued
                    if let meta = fileMeta[url] {
                        self.metadata[url] = meta
                    }
                }
            }
        }
    }

    func removeFile(_ url: URL) {
        DispatchQueue.main.async {
            self.inputFiles.removeAll { $0 == url }
            self.fileStatuses.removeValue(forKey: url)
            self.metadata.removeValue(forKey: url)
        }
    }

    func clearAllFiles() {
        DispatchQueue.main.async {
            self.inputFiles.removeAll()
            self.fileStatuses.removeAll()
            self.metadata.removeAll()
        }
    }

    func promptForOutputFolderIfNeeded() -> Bool {
        if settings.outputFolderURL == nil {
            selectOutputFolder()
            return settings.outputFolderURL != nil
        }
        return true
    }
}
