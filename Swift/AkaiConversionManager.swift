// AkaiConversionManager.swift
// AkaiSConvert
//
// Created by Brendan Spear on 2025-05-18.

import Foundation

struct AkaiConversionManager {
    static func convert(fileURL: URL, settings: ConversionSettings) {
        print("""
        Starting conversion:
        File: \(fileURL.lastPathComponent)
        Sampler: \(settings.sampler)
        Trim Silence: \(settings.trimSilence)
        Add Silence: \(settings.addSilence)
        Silence Duration: \(settings.silenceDuration) ms
        """)
    }
}
