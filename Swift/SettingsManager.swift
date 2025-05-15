//
//  SettingsManager.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

class SettingsManager: ObservableObject {
    static let shared = SettingsManager()
    
    @Published var selectedSampler: AkaiSampler = .s1000
    @Published var normalizeAudio: Bool = false
    @Published var trimSilence: Bool = false
    @Published var addSilencePadding: Bool = false
    @Published var silencePaddingMilliseconds: Int = 0
    @Published var convertToMono: Bool = false
    @Published var preferredOutputSizeKB: Int = 1440  // default for floppy disk
    
    private init() {}

    func resetToDefaults() {
        selectedSampler = .s1000
        normalizeAudio = false
        trimSilence = false
        addSilencePadding = false
        silencePaddingMilliseconds = 0
        convertToMono = false
        preferredOutputSizeKB = 1440
    }
}

