//
//  UserPreferences.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-XX.
//

import Foundation

struct UserPreferences: Codable {
    var lastUsedSampler: SamplerType
    var autoOpenLastSession: Bool
    var preferredBitDepth: UInt8
    var preferredSampleRate: UInt32
}
