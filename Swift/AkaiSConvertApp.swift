//
//  AkaiSConvertApp.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-24.
//

import SwiftUI

@main
struct AkaiSConvertApp: App {
    @StateObject private var viewModel = ConversionViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
        .commands {
            AppMenuCommands(viewModel: viewModel)
        }
    }
}
