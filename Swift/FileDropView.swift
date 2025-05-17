//
//  FileDropView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/17/25.
//

import SwiftUI

struct FileDropView: View {
    @Binding var fileURL: URL?

    var body: some View {
        VStack {
            Text(fileURL == nil ? "Drop a file here or click to select" : fileURL!.lastPathComponent)
                .padding()
                .frame(maxWidth: .infinity, minHeight: 100)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .onTapGesture {
                    let panel = NSOpenPanel()
                    panel.canChooseFiles = true
                    panel.allowsMultipleSelection = false
                    panel.canChooseDirectories = false
                    if panel.runModal() == .OK {
                        fileURL = panel.url
                    }
                }
        }
    }
}
