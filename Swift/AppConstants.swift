//
//  AppConstants.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

enum AppConstants {
    static let supportedInputExtensions: [String] = ["wav", "aiff", "aif"]
    static let supportedOutputExtensions: [String] = ["out", "akai", "img"]

    static let defaultSampleRate: UInt32 = 44100
    static let defaultBitDepth: UInt8 = 16

    static let maxAddSilenceMs = 2000
    static let defaultAddSilenceMs = 0
    static let minTrimThreshold: Float = 0.001

    static let akaiS900MaxSampleRate: UInt32 = 37500
    static let akaiS1000MaxSampleRate: UInt32 = 44100
    static let akaiS3000MaxSampleRate: UInt32 = 48000
}

