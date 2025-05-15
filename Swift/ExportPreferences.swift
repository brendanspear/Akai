//
//  ExportPreferences.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import Foundation

struct ExportPreferences {
    var convertToMono: Bool = false
    var normalize: Bool = false
    var trimSilence: Bool = false
    var addSilence: Bool = false
    var silenceDurationMs: Int = 250
    var targetBitDepth: Int = 16
    var targetSampleRate: Int = 44100
    var autoFixCompatibility: Bool = true
}

