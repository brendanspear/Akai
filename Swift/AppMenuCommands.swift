//
//  AppMenuCommands.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-24.
//

import SwiftUI

struct AppMenuCommands: Commands {
    var viewModel: ConversionViewModel

    var body: some Commands {
        CommandGroup(replacing: .newItem) {
            Button("Clear All Files") {
                viewModel.resetAll()
            }
            .keyboardShortcut("k", modifiers: [.command, .shift])
        }
    }
}
