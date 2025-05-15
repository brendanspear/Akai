//
//  OutputPathSelector.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation
import SwiftUI

class OutputPathSelector: ObservableObject {
    @Published var outputPath: URL?

    func chooseOutputFolder(completion: @escaping () -> Void) {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canCreateDirectories = true
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false
        panel.title = "Select Output Folder"

        if panel.runModal() == .OK {
            DispatchQueue.main.async {
                self.outputPath = panel.url
                completion()
            }
        }
    }

    func outputPathDisplay() -> String {
        if let url = outputPath {
            return url.path
        } else {
            return "No output folder selected"
        }
    }
}

