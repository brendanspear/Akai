//  ConversionSettings.swift
//  AkaiSConvert

import Foundation

struct ConversionSettings {
    var sampler: SamplerType
    var trimSilence: Bool
    var addSilence: Bool
    var silenceDuration: Int
    var normalizeVolume: Bool
    var convertToMono: Bool
    var sampleRate: Int
    var bitDepth: Int
    var format: SampleFormat
    var outputFolderURL: URL?
}
extension ConversionSettings {
    static func defaultSettings() -> ConversionSettings {
        return ConversionSettings(
            sampler: .s1000,
            trimSilence: false,
            addSilence: false,
            silenceDuration: 0,
            normalizeVolume: false,
            convertToMono: false,
            sampleRate: 44100,
            bitDepth: 16,
            format: .pcm16,
            outputFolderURL: nil
        )
    }
}
