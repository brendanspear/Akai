//
//  AppPreferences.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

import Foundation

struct AppPreferences: Codable {
    var defaultSampler: AkaiSampler = AkaiSampler.s1000
    var monoConversion: MonoConversionMode = .average
    var exportFormat: AudioExportFormat = .wav
}

