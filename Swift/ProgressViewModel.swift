//
//  ProgressViewModel.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation
import Combine

class ProgressViewModel: ObservableObject {
    @Published var isProcessing: Bool = false
    @Published var currentFileName: String = ""
    @Published var progressMessage: String = ""
    @Published var progressValue: Double = 0.0
    @Published var totalSteps: Int = 1
    @Published var currentStep: Int = 0

    func startProgress(for file: String, totalSteps: Int) {
        self.isProcessing = true
        self.currentFileName = file
        self.totalSteps = max(totalSteps, 1)
        self.currentStep = 0
        self.updateProgressMessage()
    }

    func advanceStep() {
        currentStep += 1
        updateProgressMessage()
    }

    func updateProgressMessage() {
        progressMessage = "Processing \(currentFileName) (\(currentStep)/\(totalSteps))"
        progressValue = Double(currentStep) / Double(totalSteps)
    }

    func finish() {
        isProcessing = false
        currentFileName = ""
        progressMessage = ""
        progressValue = 0.0
        currentStep = 0
        totalSteps = 1
    }
}

