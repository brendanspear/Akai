//
//  UserPreferences.swift
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-20.
//

import Foundation

/// Stores persistent user preferences for sampler conversion settings.
struct UserPreferences: Codable {
    var preferredSampler: String
    var trimSilence: Bool
    var addSilence: Bool
    var silenceDuration: Int
    var normalizeVolume: Bool
    var convertToMono: Bool
    var lastUsedOutputFolder: String?

    /// Default preferences to use on first launch or reset
    static var `default`: UserPreferences {
        return UserPreferences(
            preferredSampler: "S1000",
            trimSilence: false,
            addSilence: false,
            silenceDuration: 0,
            normalizeVolume: false,
            convertToMono: false,
            lastUsedOutputFolder: nil
        )
    }
}
