//
//  SamplerAnalysisResult.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

struct SamplerAnalysisResult {
    var isCompatible: Bool
    var issues: [String]
    var suggestedActions: [String]
    var normalizedPeak: Float?  // Useful if normalization was analyzed
    var sampleRate: UInt32?
    var bitDepth: UInt8?
    var channels: Int?
}

