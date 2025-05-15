//
//  AudioConversionSettings.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 5/11/25.
//
import Foundation

struct AudioConversionSettings {
    var convertToMono: Bool = false
    var normalize: Bool = false
    var trimSilence: Bool = false
    var addSilencePadding: Bool = false
    var silencePaddingMilliseconds: Int = 0
    var forceResample: Bool = false
    var forceBitDepth: Bool = false
    var targetSampleRate: UInt32? = nil
    var targetBitDepth: UInt8? = nil

    static var `default`: AudioConversionSettings {
        return AudioConversionSettings()
    }
}

