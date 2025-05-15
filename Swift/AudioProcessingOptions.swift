//
//  AudioProcessingOptions.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/10/25.
//
import Foundation

struct AudioProcessingOptions {
    var normalize: Bool = false
    var trimSilence: Bool = false
    var addSilencePadding: Bool = false
    var silencePaddingMilliseconds: Int = 0
    var convertToMono: Bool = false

    var selectedSampler: AkaiSampler = .s1000
    var outputDestination: OutputDestination = .zuluScsi
}

enum MonoConversionMode: String, CaseIterable, Codable {
    case left
    case right
    case average
    case mixdown
}

