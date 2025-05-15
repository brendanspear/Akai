//
//  ProcessingOptions.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

struct ProcessingOptions {
    var selectedSampler: AkaiSampler
    var normalize: Bool
    var trimSilence: Bool
    var addSilenceMillis: Int
    var forceMono: Bool
    var convertBitDepth: Bool
    var convertSampleRate: Bool
    
    static var `default`: ProcessingOptions {
        return ProcessingOptions(
            selectedSampler: .s900,
            normalize: false,
            trimSilence: false,
            addSilenceMillis: 0,
            forceMono: false,
            convertBitDepth: true,
            convertSampleRate: true
        )
    }
}

