//
//  SamplerSettingsViewModel.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation
import Combine

class SamplerSettingsViewModel: ObservableObject {
    @Published var selectedSampler: AkaiSampler = .s1000
    @Published var forceMono: Bool = false
    @Published var convertSampleRate: Bool = false
    @Published var targetSampleRate: UInt32 = 44100
    @Published var convertBitDepth: Bool = false
    @Published var targetBitDepth: UInt8 = 16
    @Published var normalizeAudio: Bool = false
    @Published var trimSilence: Bool = false
    @Published var addSilencePadding: Bool = false
    @Published var silencePaddingDurationMs: UInt = 50
    @Published var autoFixIncompatibility: Bool = true

    func resetToDefaults(for sampler: AkaiSampler) {
        selectedSampler = sampler
        forceMono = sampler.isMonoOnly
        convertSampleRate = false
        targetSampleRate = sampler.maxSampleRate
        convertBitDepth = false
        targetBitDepth = sampler.supportedBitDepths.first ?? 16
        normalizeAudio = false
        trimSilence = false
        addSilencePadding = false
        silencePaddingDurationMs = 50
        autoFixIncompatibility = true
    }
}
