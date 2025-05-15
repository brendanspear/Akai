//
//  SampleInfo.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

struct SampleInfo {
    let filename: String
    let duration: Double // in seconds
    let sampleRate: UInt32
    let bitDepth: UInt8
    let isStereo: Bool
    let isCompatible: Bool
    let needsConversion: Bool
    let warningMessage: String?
}

