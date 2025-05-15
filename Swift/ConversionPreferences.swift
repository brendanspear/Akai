//
//  ConversionPreferences.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

final class ConversionPreferences: ObservableObject {
    @Published var selectedSampler: AkaiSampler = .s900

    @Published var normalizeAudio: Bool = false
    @Published var trimSilence: Bool = false
    @Published var convertToMono: Bool = false
    @Published var addSilencePadding: Bool = false
    @Published var autoFixIncompatibleFiles: Bool = true

    @Published var silencePaddingMilliseconds: Int = 100
    @Published var trimThresholdDb: Float = -60.0

    var compatibilitySettings: SamplerCompatibility {
        return SamplerCompatibility(for: selectedSampler)
    }
}

