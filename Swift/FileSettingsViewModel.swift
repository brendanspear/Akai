//
//  FileSettingsViewModel.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation
import Combine

class FileSettingsViewModel: ObservableObject {
    @Published var selectedFiles: [URL] = []
    @Published var outputDirectory: URL? = nil
    @Published var includeSubfolders: Bool = false
    @Published var overwriteExisting: Bool = false

    func addFiles(_ urls: [URL]) {
        selectedFiles.append(contentsOf: urls.filter { !selectedFiles.contains($0) })
    }

    func clearFiles() {
        selectedFiles.removeAll()
    }

    func setOutputDirectory(_ url: URL) {
        outputDirectory = url
    }

    func removeFile(at offsets: IndexSet) {
        selectedFiles.remove(atOffsets: offsets)
    }
}

