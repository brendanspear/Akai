//
//  ConversionSettings.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import Foundation

struct ConversionSettings {
    var targetSampler: SamplerTarget
    var normalize: Bool
    var trimSilence: Bool
    var addTailSilenceMS: Int
    var convertToMono: Bool
    var convertStereoToMonoEvenIfSupported: Bool
    var autoFixIncompatibleFiles: Bool
    var outputFormat: AudioExportFormat
    var outputPath: URL?

    init(
        targetSampler: SamplerTarget = .s900,
        normalize: Bool = false,
        trimSilence: Bool = false,
        addTailSilenceMS: Int = 0,
        convertToMono: Bool = false,
        convertStereoToMonoEvenIfSupported: Bool = false,
        autoFixIncompatibleFiles: Bool = true,
        outputFormat: AudioExportFormat = .akaiDisk,
        outputPath: URL? = nil
    ) {
        self.targetSampler = targetSampler
        self.normalize = normalize
        self.trimSilence = trimSilence
        self.addTailSilenceMS = addTailSilenceMS
        self.convertToMono = convertToMono
        self.convertStereoToMonoEvenIfSupported = convertStereoToMonoEvenIfSupported
        self.autoFixIncompatibleFiles = autoFixIncompatibleFiles
        self.outputFormat = outputFormat
        self.outputPath = outputPath
    }
}

