//
//  SamplerSettings.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-11.
//

import Foundation

struct SamplerSettings {
    var samplerType: SamplerType = .s1000
    var outputFolderURL: URL? = nil
    var trimSilence: Bool = false
    var padSilence: Bool = false
    var normalizeVolume: Bool = false
    var exportAsWAV: Bool = false

    mutating func resetToDefaults() {
        self.samplerType = .s1000
        self.outputFolderURL = nil
        self.trimSilence = false
        self.padSilence = false
        self.normalizeVolume = false
        self.exportAsWAV = false
    }
}
