//
//  ConversionOptions.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

struct ConversionOptions {
    var selectedSampler: AkaiSampler
    var normalizeAudio: Bool
    var trimSilence: Bool
    var addSilenceMs: Int
    var forceMono: Bool
    var autoFixIncompatible: Bool
    var outputPath: URL?

    init(
        selectedSampler: AkaiSampler = .s900,
        normalizeAudio: Bool = false,
        trimSilence: Bool = false,
        addSilenceMs: Int = 0,
        forceMono: Bool = false,
        autoFixIncompatible: Bool = true,
        outputPath: URL? = nil
    ) {
        self.selectedSampler = selectedSampler
        self.normalizeAudio = normalizeAudio
        self.trimSilence = trimSilence
        self.addSilenceMs = addSilenceMs
        self.forceMono = forceMono
        self.autoFixIncompatible = autoFixIncompatible
        self.outputPath = outputPath
    }
}

