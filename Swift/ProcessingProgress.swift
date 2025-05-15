//
//  ProcessingProgress.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation
import SwiftUI

class ProcessingProgress: ObservableObject {
    @Published var isProcessing: Bool = false
    @Published var progressMessage: String = "Ready"

    func startProcessing() {
        DispatchQueue.main.async {
            self.isProcessing = true
            self.progressMessage = "Processing..."
        }
    }

    func updateMessage(_ message: String) {
        DispatchQueue.main.async {
            self.progressMessage = message
        }
    }

    func finishProcessing(success: Bool) {
        DispatchQueue.main.async {
            self.isProcessing = false
            self.progressMessage = success ? "Processing complete ✅" : "Processing failed ❌"
        }
    }

    func reset() {
        DispatchQueue.main.async {
            self.isProcessing = false
            self.progressMessage = "Ready"
        }
    }
}

