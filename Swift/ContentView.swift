import SwiftUI

struct ContentView: View {
    @State private var selectedFiles: [URL] = []
    @State private var outputDirectory: URL?
    @State private var conversionLog: [String] = []

    var body: some View {
        VStack {
            Button("Select WAV/AIFF Files") {
                let panel = NSOpenPanel()
                panel.allowsMultipleSelection = true
                panel.allowedFileTypes = ["wav", "aif", "aiff"]
                if panel.runModal() == .OK {
                    selectedFiles = panel.urls
                }
            }

            Button("Select Output Folder") {
                let panel = NSOpenPanel()
                panel.canChooseDirectories = true
                panel.canChooseFiles = false
                panel.allowsMultipleSelection = false
                if panel.runModal() == .OK {
                    outputDirectory = panel.url
                }
            }

            Button("Convert to S900") {
                if let outDir = outputDirectory {
                    conversionLog = AkaiProcessor.convertMultipleWavFiles(
                        fileURLs: selectedFiles,
                        outputDirectory: outDir,
                        model: .s900
                    )
                }
            }

            Button("Convert to S1000") {
                if let outDir = outputDirectory {
                    conversionLog = AkaiProcessor.convertMultipleWavFiles(
                        fileURLs: selectedFiles,
                        outputDirectory: outDir,
                        model: .s1000
                    )
                }
            }

            ScrollView {
                ForEach(conversionLog, id: \.self) { line in
                    Text(line)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
    }
}

