//
//  ContentView.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-15.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ConversionViewModel()

    var body: some View {
        VStack(spacing: 20) {

            VStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [8]))
                    .background(Color.clear)
                    .frame(height: 100)
                    .overlay(
                        VStack(spacing: 5) {
                            Text("Drag and drop files or folders here")
                                .foregroundColor(.gray)
                            Text("or click anywhere to select")
                                .font(.callout)
                                .foregroundColor(.blue)
                        }
                    )
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.selectInputFiles()
                    }
                    .onDrop(of: [.fileURL], isTargeted: nil) { providers in
                        viewModel.handleDroppedItems(providers: providers)
                        return true
                    }
            }
            .padding(.horizontal)

            if !viewModel.inputFiles.isEmpty {
                VStack(alignment: .leading) {
                    WaveformPreviewView(
                        files: viewModel.inputFiles,
                        statuses: viewModel.fileStatuses,
                        metadata: viewModel.metadata,
                        removeAction: viewModel.removeFile
                    )
                    .padding(.bottom, 10)
                }
                .padding(.horizontal)
            }

            SamplerSettingsView(viewModel: SamplerSettingsViewModel(settings: $viewModel.settings))
                .padding(.horizontal)

            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 12) {
                    Button("Select Output Folder") {
                        viewModel.selectOutputFolder()
                    }

                    Button("Reset") {
                        viewModel.inputFiles = []
                        viewModel.settings = .defaultSettings()
                        viewModel.fileStatuses.removeAll()
                        viewModel.metadata.removeAll()
                    }
                    .foregroundColor(.red)
                }

                if let outputURL = viewModel.settings.outputFolderURL {
                    Text(outputURL.path)
                        .font(.caption)
                        .lineLimit(1)
                        .truncationMode(.middle)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)

            Button(action: {
                if viewModel.promptForOutputFolderIfNeeded() {
                    for file in viewModel.inputFiles {
                        TaskRunner.runInBackground {
                            _ = SampleConverter.convert(
                                inputURL: file,
                                settings: viewModel.settings
                            )
                        }
                    }
                }
            }) {
                Text("Convert Samples")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .frame(minWidth: 600, minHeight: 700)
    }
}
