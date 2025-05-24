//
//  ConversionSettings.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-24.
//

import Foundation

struct ConversionSettings {
    var outputFolderURL: URL?
    var sampler: SamplerType = .s1000
    var normalize: Bool = false
    var trimSilence: Bool = false
    var addSilence: Bool = false
    var silenceDuration: Double = 0.25
    var convertToMono: Bool = false

    static func defaultSettings() -> ConversionSettings {
        return ConversionSettings(
            outputFolderURL: nil,
            sampler: .s1000,
            normalize: false,
            trimSilence: false,
            addSilence: false,
            silenceDuration: 0.25,
            convertToMono: false
        )
    }
}
