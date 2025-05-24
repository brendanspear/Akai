//  AppMenuCommands.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-23.
//

import SwiftUI

struct AppMenuCommands: Commands {
    @ObservedObject var viewModel: ConversionViewModel

    var body: some Commands {
        CommandGroup(replacing: .newItem) {
            Button("Clear All Files") {
                viewModel.clearAllFiles()
            }
            .keyboardShortcut("k", modifiers: [.command])
        }
    }
}
