//
//  AppSettings.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import Foundation

class AppSettings: ObservableObject {
    static let shared = AppSettings()

    @Published var selectedSampler: AkaiSampler = .s1000
    @Published var normalize: Bool = false
    @Published var trimSilence: Bool = false
    @Published var addSilence: Bool = false
    @Published var silenceDurationMs: Int = 0
    @Published var targetOutputSizeKB: Int = 0
    @Published var autoFixIncompatibleFiles: Bool = true
    @Published var enableWarnings: Bool = true

    private init() {}
}
